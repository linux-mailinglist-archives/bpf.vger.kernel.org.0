Return-Path: <bpf+bounces-15777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DD7F6872
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 21:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36841C20CBD
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246724D5AD;
	Thu, 23 Nov 2023 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THhYyzot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C276D48;
	Thu, 23 Nov 2023 12:24:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf6af8588fso10168645ad.0;
        Thu, 23 Nov 2023 12:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700771053; x=1701375853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLlC/dJoKnBsq40T11wjOkgrL4zOea/ZdH3kSMhrylg=;
        b=THhYyzotB0bXj+I3dweR3lDwxAOjsOK5QhkUMMYm1tLb7PSl7lmOIMhc+d6zuportl
         dsNGyJJalKQg1y+FA0qSK9m3H5/xpHz1M2e47DtOsnjWEOjLnRd64ej//0JrDhL73VgK
         tj7lOxaxK2pliRaSkcKPqy6+JlW81rR1V1tBxZ9WGR/7FsiahR2RbrYlfOZNEdoSgU7x
         QNwSnmx6LV6/Icq+Sbm3+shfxh6OMsm83NJnHVBiN7QasmDHjVj470Q5MGIiEIme94bt
         a8wPRw12lcwWbWLsMsfgGCKEqBoz+sq6HOQJIV7fMfhAfjtBg4pIFuCWHeS6uDSmVRiN
         r8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700771053; x=1701375853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLlC/dJoKnBsq40T11wjOkgrL4zOea/ZdH3kSMhrylg=;
        b=B/3fhYosSMQr7IFc8/vnSnpEwuPNbw5/k/uX0hGC7Gzi3AgVFr0fd63L8irZ+LZGq4
         84/kbits/Xu8bFhjMGHUPjtwLMxDbGzMFzFEZ5sZNxo+YMF00qNh4o7cCZzID7VdoPP0
         IT/usS6BdpkgZh10RzG7xJ2QM9EsyH/17QVxbu8QlM6uK5Omy2M/PKvgFT8Ta3zndsOq
         fAFqhwnqvcrfHfo6OdZ67MCSLqQnM9kbzUB6YsCJqhjKsPnC3ekCzI3mXOUmPL5WDrmu
         vQXWLvb0qi/czOUxmgORo5gm0VTVXzfribhJu5qgGi83QIYrPvQPKzvO3vG3sA7R5g3r
         oeIQ==
X-Gm-Message-State: AOJu0YxdXc/XHq0pQKU4BDYmHrkcN4M4uyQf9mXQBzXlNnSqzONe0v/a
	2o+8qwtmjvn4b4BHos0QZPE=
X-Google-Smtp-Source: AGHT+IEt7ICLkZYe8zRb4xlYybcFLG/kBZGpUFuij0RKetT92rh4Yr4NNWkRgd0YY6aJiyJ4AI7EbA==
X-Received: by 2002:a17:902:ced0:b0:1cc:ae1a:b0b8 with SMTP id d16-20020a170902ced000b001ccae1ab0b8mr712485plg.44.1700771053493;
        Thu, 23 Nov 2023 12:24:13 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:1c5b:38d7:d29e:337c])
        by smtp.gmail.com with ESMTPSA id jw11-20020a170903278b00b001ca4ad86357sm1749503plb.227.2023.11.23.12.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 12:24:12 -0800 (PST)
Date: Thu, 23 Nov 2023 12:24:12 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: martin.lau@kernel.org, jakub@cloudflare.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: sockmap, af_unix stream sockets need to
 hold ref for pair sock
Message-ID: <ZV+07PlDoxrcAn9c@pop-os.localdomain>
References: <20231122192452.335312-1-john.fastabend@gmail.com>
 <20231122192452.335312-2-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122192452.335312-2-john.fastabend@gmail.com>

On Wed, Nov 22, 2023 at 11:24:51AM -0800, John Fastabend wrote:
> AF_UNIX stream sockets are a paired socket. So sending on one of the pairs
> will lookup the paired socket as part of the send operation. It is possible
> however to put just one of the pairs in a BPF map. This currently
> increments the refcnt on the sock in the sockmap to ensure it is not
> free'd by the stack before sockmap cleans up its state and stops any
> skbs being sent/recv'd to that socket.
> 
> But we missed a case. If the peer socket is closed it will be
> free'd by the stack. However, the paired socket can still be
> referenced from BPF sockmap side because we hold a reference
> there. Then if we are sending traffic through BPF sockmap to
> that socket it will try to dereference the free'd pair in its
> send logic creating a use after free.  And following splat,

Hmm, how could it pass the SOCK_DEAD test in unix_stream_sendmsg()?

2285                 unix_state_lock(other);
2286
2287                 if (sock_flag(other, SOCK_DEAD) ||
2288                     (other->sk_shutdown & RCV_SHUTDOWN))
2289                         goto pipe_err_free;


Thanks.

