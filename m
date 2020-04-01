Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBBC19B8EF
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgDAX2y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 19:28:54 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:45443 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbgDAX2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 19:28:54 -0400
Received: by mail-pf1-f171.google.com with SMTP id r14so783149pfl.12
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 16:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbTNkb7dEJV/jUuDYaV6ronUZJKT0J6YmMyYLmqZPyU=;
        b=I4qPhH9OYmT7g9sEyW60xEZxFTOgLVe4PF4Hh3yIcEsq++K+8kbwMm/41kvHEWIlh+
         +D80h6iaELN3eQT1/UGl8CgWOYk2+WuDpGVJX2G0C3oRFrmw0lhx8Zmh9KyLCn4lXS2w
         pKx5m1DJx9T1ksJgD1DO89LIecwRc+Ts+ATacxUFmuNCOtJqnsOPD7br9Tt1bD7vWGlU
         KhwMhsEtQkS05TYV+Pz/MxkNfrVWXSf6un7X6jRaoUpqkz/W8ejhh9ag84JvZIb75MVZ
         aa5SRgn2UsjC7YLuMJe+iZcbx1fXtb5WW67p7rPWAn9WjRTwdTAmqxmf1nBzztMsBA4w
         FQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbTNkb7dEJV/jUuDYaV6ronUZJKT0J6YmMyYLmqZPyU=;
        b=eNitEYIN1vCo3kMZBgXpp8IHBUZa3pNwNAm33Q36c5YPUMKaAoiQFUGh4g/CMOAHXx
         nhY6bCVxCt41SzxNorFb4Arpk1048TkgF2WgaiAISHo341uvJULFkUN4FKx+QouI6Uj1
         /ETuHXHjaLaKf4fjAKG7f7HyNEa0fvkDTrZvVsmQFvktO2LDYaVFAs/4P7le1MhOyZTw
         M22uE8a2wDREY4BM5xj38h6ehZ0rPHIarqMuHItSF923F9zYyZUbmFZUls5klOXVGWbc
         KsI2cIrgkbCdd8MwL/If4A5/PehTOwG992VPooaudxJXZ9Ap/AI8cfRU54Fi8npPSNzu
         p9AQ==
X-Gm-Message-State: AGi0PuY4YxU+P8hCzZKeywKyNUqTDFLXyXBjhBb15ss3SkGn12qeY+z9
        /KNzk4A6LBKxhOzVZd1BcFx8rppe
X-Google-Smtp-Source: APiQypJBK7YzoSvI90CiSCgCoUdQz8WmbDSMYgtsMaoFQethyWnTW31HSt9Y8LFAndIxznIlhbE1JA==
X-Received: by 2002:aa7:949d:: with SMTP id z29mr199435pfk.111.1585783732897;
        Wed, 01 Apr 2020 16:28:52 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:557f])
        by smtp.gmail.com with ESMTPSA id e80sm2452233pfh.117.2020.04.01.16.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 16:28:52 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:28:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Gilad Reti <gilad.reti@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: probe_write_common_error
Message-ID: <20200401232849.wms6vfuozvis5t2s@ast-mbp>
References: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 07:16:28PM +0300, Gilad Reti wrote:
> When I try to probe_write_common into a writable location (e.g a
> memory address on a usermode stack) which is not yet mapped or mapped
> as read only to the memory, the function sometimes return a EFAULT
> (bad address) error. This is happening since the pagefault handler was
> disabled and thus this memory location won't be mapped when the
> function tries to write into it, an error will be returned and no data
> will be written.
> Is that behavior intended? Did you want those functions to have as
> less side-effects are possible?

You mean bpf_probe_write_user() helper?
Yes it's a non-faulting helper that will fail if prog is trying to
write into a valid memory that could have been served with minor fault.
The main reason for this is that bpf progs are not allowed to sleep.
We're working on sleepable bpf progs that will be able to do copy_from/to_user
from the context where it is safe to sleep. Like syscall entry.
Could you please share more about your use case, so we can make sure
that it will be covered by upcoming work?
