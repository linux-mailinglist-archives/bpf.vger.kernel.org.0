Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E778D495D
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfJKUhU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 16:37:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35611 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfJKUhU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 16:37:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id c3so4987073plo.2
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J4MqgFNM5y+7nBh+ffpE144qKI33NcNHQj2XoGXLwVM=;
        b=tkK3UIajRfQmCFNhdVJ2Y7jc3R2zJ147vvzfIyTfW92R5JBwvJUBEnXiqEVW+xr356
         jBY4KUMhOPWg2fjUi24Rw7Nbf6PqSPY4xb0Quk99xZQmKggiV382kwWuIZ4vJMUr67+n
         dnXUrWWhzPzGUlI/NtnsKU7FWMwYgEL4Z8Fc7KKZ1TQw3v4mQuBGZNWJmQd8jNUbuQlc
         ypxAhjBW8m1zfGUqcpsC+8bUl/mSu7nDX5Z9rsjrzMRQaXkOWnFrQpmPStWU+mgC7Ykl
         Rkf1JbUq+Z/5yvgG1Qf4SBjkVdi2PcWICGSKYax0BOgRpj4geZgVzE7xyxDmn3hRJvid
         l4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J4MqgFNM5y+7nBh+ffpE144qKI33NcNHQj2XoGXLwVM=;
        b=Jl2FXKUq4ju2u+xSWLPGL+8igEw50rNulLIS2UwNq7Edq7MDH14bOE/w31aRXqDs72
         G3fzODB68SgRQc/Tvs84UWM0MxkdR97ukZvscPOgJuaUgfizmgwVimzbJNEbSFub0Lc9
         u1QJRC1StvUmIn0Phf20CNxlGdFtOw9nIe3+ihmNpZ69zjoupxa0utmazA3qKp86erZs
         d0Dzajh4WrjVzfFTjYWBu7INZJGtuPZmv5A/AAuU7u5Osl7rOnnFFeksHzR4GFat9Th1
         1VoF7r8LwPEzemxlyPOnchZEku9WH3QW7Ida94VMb6TZx2dmPSfGBYC/Cfl1n7tiPj90
         VL8A==
X-Gm-Message-State: APjAAAURQvrRAhR5gOpdfQ3NzXJJqv+zEcKepvWJQT938c8mhuc568ov
        LwL4Vq86DxrM6kLq9PrB1CsCB3K346A=
X-Google-Smtp-Source: APXvYqwI1j1tsdYbea9fjPC8PcuvKIVKm/2V+sqqaHHRkAnLYqX2Q/Mi6eYdh9hGAB26X8iaCfUGsA==
X-Received: by 2002:a17:902:a70f:: with SMTP id w15mr16988463plq.146.1570826238066;
        Fri, 11 Oct 2019 13:37:18 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id f13sm4104924pgr.6.2019.10.11.13.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 13:37:16 -0700 (PDT)
Date:   Fri, 11 Oct 2019 13:37:16 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Martin Lau <kafai@fb.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 3/3] bpftool: print the comm of the process that
 loaded the program
Message-ID: <20191011203716.GI2096@mini-arch>
References: <20191011162124.52982-1-sdf@google.com>
 <20191011162124.52982-3-sdf@google.com>
 <20191011201910.ynztujumh7dlluez@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011201910.ynztujumh7dlluez@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/11, Martin Lau wrote:
> On Fri, Oct 11, 2019 at 09:21:24AM -0700, Stanislav Fomichev wrote:
> > Print recently added created_by_comm along the existing created_by_uid.
> > 
> > Example with loop1.o (loaded via bpftool):
> > 4: raw_tracepoint  name nested_loops  tag b9472b3ff5753ef2  gpl
> >         loaded_at 2019-10-10T13:38:18-0700  uid 0  comm bpftool
> >         xlated 264B  jited 152B  memlock 4096B
> >         btf_id 3
> Hopefully CAP_BPF may avoid uid 0 in the future.
Yeah, but this also requires creating a user with CAP_BPF and running
a daemon under this user.

> What will be in "comm" for the python bcc script?
I guess it will be "python". But at least you get a signal that it's
not some other system daemon :-)

> > 
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/bpf/bpftool/prog.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index 27da96a797ab..400771a942d7 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -296,7 +296,9 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
> >  		print_boot_time(info->load_time, buf, sizeof(buf));
> >  
> >  		/* Piggy back on load_time, since 0 uid is a valid one */
> > -		printf("\tloaded_at %s  uid %u\n", buf, info->created_by_uid);
> > +		printf("\tloaded_at %s  uid %u  comm %s\n", buf,
> > +		       info->created_by_uid,
> > +		       info->created_by_comm);
> >  	}
> >  
> >  	printf("\txlated %uB", info->xlated_prog_len);
> > -- 
> > 2.23.0.700.g56cf767bdb-goog
> > 
