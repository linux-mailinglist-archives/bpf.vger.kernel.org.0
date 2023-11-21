Return-Path: <bpf+bounces-15594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E147F3799
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEFF628273B
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50555791;
	Tue, 21 Nov 2023 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5Ve+PMx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3511210C
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:38:10 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc2fc281cdso42256885ad.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700599089; x=1701203889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l1hk3qZeaM7c7oBivNAl1xpNadwLMnXFOxJSloUhdhs=;
        b=N5Ve+PMxaGpbLwrNqLHbOOG3WNz7cGrssG0eeKmK/9uxViOInJRgj64CoeYmIH1T0T
         qbCscp7UwY1TDOthPWnXYZThCyF5PPCD+ZoZqFFprzQxhf9OjarU+Wqm4qIabuBETBaO
         ZqNsFLJIOcIcV4jgnncaTI9OXYHVCo3Wpy+hyor8+HwTQCyERTfJKaz1xfbMeVPV4xTx
         mcIYlOZSww6qhvHrNY9zDp10MTtKYRnuI2FWKZtX4tekNlF5V1FNy9IEsbNgjozP/m6U
         5j28/3i2cLPtuQgcQxlgGdI+8dGdMcj0ABazNIiIUeBwfetxtfLSAqAT7RudPKVMVeGD
         TWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700599089; x=1701203889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1hk3qZeaM7c7oBivNAl1xpNadwLMnXFOxJSloUhdhs=;
        b=pZ62oZdmHzUtFfEI4H2axqWkG/ETRB2CNf5JNL8rWn9R7LO4qLyPxiADVKyEAlhMdT
         26NqrYd010J2rTFJk1wYY2+jZAoqweU3ojgrsZZYRVctzSwTeOMDoCcuZp4L5WCmY33d
         GnJVh3EVPMwY6PGm21F0ekQ0qErTCfjmtVw+QX2vTbVEglp6vs74dOUXHr9Ca5mwcWog
         FntEUu9FY3lcSMz7DLkH/JNbTJEhQETklXzHsrePZESJOjyyO6saX2C9dxs3nk6XySpq
         5diJI7a72SdlHY6UlJMQ8Jy5mloaLdaGCqv7duSbvagOy2wW5/z1/sAyEwjXdGtQEA8C
         KTlA==
X-Gm-Message-State: AOJu0YxysOCU/TKTfa1xLXkbzJjLwHsCDcnvo1RQMUesMn2LeDazhsay
	oUEoSLh1PQq9/BLdYNGx+r4=
X-Google-Smtp-Source: AGHT+IGu1D7smSGI+pd2HefZzhp5USC25+53Qd9+3bAcZh1FvxUkVAZ010jk+nhLfkm1z+p438fXsg==
X-Received: by 2002:a17:902:e5c6:b0:1cf:662b:44f9 with SMTP id u6-20020a170902e5c600b001cf662b44f9mr289343plf.69.1700599089405;
        Tue, 21 Nov 2023 12:38:09 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:500::4:8368])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cf5d324817sm4481779plg.188.2023.11.21.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:38:08 -0800 (PST)
Date: Tue, 21 Nov 2023 12:38:06 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/10] bpf: track aligned STACK_ZERO cases as
 imprecise spilled registers
Message-ID: <20231121203806.43i6tytzwdzeoqvg@macbook-pro-49.dhcp.thefacebook.com>
References: <20231121002221.3687787-1-andrii@kernel.org>
 <20231121002221.3687787-9-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121002221.3687787-9-andrii@kernel.org>

On Mon, Nov 20, 2023 at 04:22:19PM -0800, Andrii Nakryiko wrote:
> include it here. But the reduction in states is due to the following
> piece of C code:
> 
>         unsigned long ino;
> 
> 	...
> 
>         sk = s->sk_socket;
>         if (!sk) {
>                 ino = 0;
>         } else {
>                 inode = SOCK_INODE(sk);
>                 bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
>         }
>         BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
> 	return 0;
> 
> You can see that in some situations `ino` is zero-initialized, while in
> others it's unknown value filled out by bpf_probe_read_kernel(). Before
> this change both branches have to be validated twice. Once with

I think you wanted to say that the code _after_ both branches converge
had to be validated twice.
With or without this patch both branches (ino = 0 and probe_read)
will be validated only once. It's the code that after the branch
that gets state pruned after this patch.

> (precise) ino == 0, due to eager STACK_ZERO logic, and then again for
> when ino is just STACK_MISC. But BPF_SEQ_PRINTF() doesn't care about
> precise value of ino, so with the change in this patch verifier is able
> to prune states from one of the branches, reducing number of total
> states (and instructions) required for successful validation.

This part is good.

