Return-Path: <bpf+bounces-18535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C034681B93F
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67F3B29209
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D446D6FE;
	Thu, 21 Dec 2023 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI9EF/Qi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8706D6EF;
	Thu, 21 Dec 2023 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33687627ad0so621892f8f.2;
        Thu, 21 Dec 2023 06:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703167209; x=1703772009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ExPiPxzB83kaxWbsFLRy5OgpiLlfDkyamfeCPS9DReU=;
        b=hI9EF/Qi+v9sH4LjIFUNVzNYdeNIHyKen2IuPcZAlWh/u4jEcL9mseZDB6vmnpUd6x
         fMG4G/AcikZNuaMV14vJfZsOQOT9tbV2KffLHRmeO9zUeBwS0lAEb1DLxd/d1dU1Z0xJ
         u2+Eb99A3z8IbaLCBzLZprV3fL0q1chntClfaKVEIJVvPwhMB8OSPnWQi7QDx1xup0c/
         Fn+nF6htIVvEa1k2qLTNDP3/XQ6tXtUEyJ+1EotXJEzE+Sddgig2jSANWnbzFYqjzzEh
         T2heUAtMLqDsGQyMWO+dAI6XsjEdJgHo4cFwTvRxJN+/ZZX7IWciQWxFZ3ixWMAsebuz
         6Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703167209; x=1703772009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExPiPxzB83kaxWbsFLRy5OgpiLlfDkyamfeCPS9DReU=;
        b=MlbzET/oEkd3ihuX9RLFiHCulNLEN12lJfkvLpBwo2pKG5k4+Gk8n/806LF3Rqy2uL
         TVEmEt8nPKuzoih3D/S1p3ek3VrLcZRzAhSwbWP7y8l6UIu+9dp5fu3mI36AvZXyT4no
         5IsiRAWz1ek6VNtw8sDrMKBdwFV9yCY+sa6s+JGEvbDltxPDwSiUDgQ2MkC+shNAz3dU
         IlKsq+Mm9ZkQRR3AvTMv9pYTi/y8/KbXLJggtLtNA1GTFNYPgJd1w89+J749LduO7fds
         eqSG5TRTuQJvf7b3G1Mlwd86pV0bj51IzdDCrpIG60hKmfsIz6oXLEDNS7w8GNgrXhG8
         p5tQ==
X-Gm-Message-State: AOJu0Yzx3BOSXlGwL3KLeYLeKl5bK68CbPg2X2HjrUP944676mzQQPS5
	Qad8dMussgy5aqqJHBL5t+0=
X-Google-Smtp-Source: AGHT+IHp3WVv6z3Ss0ro24ugXupertKkAHhY0uQMCPuYsb0qIURuCsnhRgztvQ3HHOAu79lykpB1lg==
X-Received: by 2002:a5d:44c4:0:b0:336:60e9:483 with SMTP id z4-20020a5d44c4000000b0033660e90483mr766521wrr.125.1703167208831;
        Thu, 21 Dec 2023 06:00:08 -0800 (PST)
Received: from krava (cst-prg-25-205.cust.vodafone.cz. [46.135.25.205])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d530e000000b0033668ac65ddsm2107333wrv.25.2023.12.21.06.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:00:08 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Dec 2023 15:00:05 +0100
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCHv4 bpf 1/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <ZYRE5dF6j63fEv8A@krava>
References: <20231206083041.1306660-1-jolsa@kernel.org>
 <20231206083041.1306660-2-jolsa@kernel.org>
 <20231221090745.GA431072@google.com>
 <2023122113-thirsting-county-ca67@gregkh>
 <20231221095522.GB10102@google.com>
 <2023122132-splashing-blip-ced4@gregkh>
 <20231221101744.GD10102@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231221101744.GD10102@google.com>

On Thu, Dec 21, 2023 at 10:17:44AM +0000, Lee Jones wrote:
> On Thu, 21 Dec 2023, Greg KH wrote:
> 
> > On Thu, Dec 21, 2023 at 09:55:22AM +0000, Lee Jones wrote:
> > > On Thu, 21 Dec 2023, Greg KH wrote:
> > > 
> > > > On Thu, Dec 21, 2023 at 09:07:45AM +0000, Lee Jones wrote:
> > > > > Dear Stable,
> > > > > 
> > > > > > Lee pointed out issue found by syscaller [0] hitting BUG in prog array
> > > > > > map poke update in prog_array_map_poke_run function due to error value
> > > > > > returned from bpf_arch_text_poke function.
> > > > > > 
> > > > > > There's race window where bpf_arch_text_poke can fail due to missing
> > > > > > bpf program kallsym symbols, which is accounted for with check for
> > > > > > -EINVAL in that BUG_ON call.
> > > > > > 
> > > > > > The problem is that in such case we won't update the tail call jump
> > > > > > and cause imbalance for the next tail call update check which will
> > > > > > fail with -EBUSY in bpf_arch_text_poke.
> > > > > > 
> > > > > > I'm hitting following race during the program load:
> > > > > > 
> > > > > >   CPU 0                             CPU 1
> > > > > > 
> > > > > >   bpf_prog_load
> > > > > >     bpf_check
> > > > > >       do_misc_fixups
> > > > > >         prog_array_map_poke_track
> > > > > > 
> > > > > >                                     map_update_elem
> > > > > >                                       bpf_fd_array_map_update_elem
> > > > > >                                         prog_array_map_poke_run
> > > > > > 
> > > > > >                                           bpf_arch_text_poke returns -EINVAL
> > > > > > 
> > > > > >     bpf_prog_kallsyms_add
> > > > > > 
> > > > > > After bpf_arch_text_poke (CPU 1) fails to update the tail call jump, the next
> > > > > > poke update fails on expected jump instruction check in bpf_arch_text_poke
> > > > > > with -EBUSY and triggers the BUG_ON in prog_array_map_poke_run.
> > > > > > 
> > > > > > Similar race exists on the program unload.
> > > > > > 
> > > > > > Fixing this by moving the update to bpf_arch_poke_desc_update function which
> > > > > > makes sure we call __bpf_arch_text_poke that skips the bpf address check.
> > > > > > 
> > > > > > Each architecture has slightly different approach wrt looking up bpf address
> > > > > > in bpf_arch_text_poke, so instead of splitting the function or adding new
> > > > > > 'checkip' argument in previous version, it seems best to move the whole
> > > > > > map_poke_run update as arch specific code.
> > > > > > 
> > > > > > [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> > > > > > 
> > > > > > Cc: Lee Jones <lee@kernel.org>
> > > > > > Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > > > > > Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> > > > > > Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
> > > > > > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > ---
> > > > > >  arch/x86/net/bpf_jit_comp.c | 46 +++++++++++++++++++++++++++++
> > > > > >  include/linux/bpf.h         |  3 ++
> > > > > >  kernel/bpf/arraymap.c       | 58 +++++++------------------------------
> > > > > >  3 files changed, 59 insertions(+), 48 deletions(-)
> > > > > 
> > > > > Please could we have this backported?
> > > > > 
> > > > > Guided by the Fixes: tag.
> > > > 
> > > > <formletter>
> > > > 
> > > > This is not the correct way to submit patches for inclusion in the
> > > > stable kernel tree.  Please read:
> > > >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > > > for how to do this properly.
> > > > 
> > > > </formletter>
> > > 
> > > Apologies.
> > > 
> > > Commit ID: 4b7de801606e504e69689df71475d27e35336fb3
> > > Subject:   bpf: Fix prog_array_map_poke_run map poke update
> > > Reason:    Fixes a race condition in BPF.
> > > Versions:  linux-5.10.y+, as specified by the Fixes: tag above
> > 
> > Did not apply to 5.10.y or 5.15.y, so if you need/want it there, we will
> > need a working backport that has been tested.  Other trees it's now
> > queued up for.
> 
> Thank you.

please let me know if you need any help with that, I can check on that

jirka

> 
> > BPF developers, please remember, just adding a "Fixes:" tag does NOT
> > guarantee that any patch will be backported to any stable kernel, you
> > MUST add a "cc: stable@..." tag to the patch if you wish to have it
> > automatically backported.
> 
> -- 
> Lee Jones [李琼斯]

