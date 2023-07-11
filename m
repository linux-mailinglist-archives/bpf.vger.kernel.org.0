Return-Path: <bpf+bounces-4797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB974F827
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 20:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6FC1C20E22
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AC71E521;
	Tue, 11 Jul 2023 18:52:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBE171D9;
	Tue, 11 Jul 2023 18:52:03 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BACE;
	Tue, 11 Jul 2023 11:51:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so12234085a12.0;
        Tue, 11 Jul 2023 11:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689101517; x=1691693517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjBk32bDKWriayySjcCwFWFBVPsxDvmwmB8EY4pgaXw=;
        b=D+dgTFS0fudTHdRH/KMS9Mo1mwhyaO1cJiqoo84KQgCjpkHhwN2sLXjGm0zS9KB3Rj
         hPMRPtG9O6K+EWjp/S/EefyHsSdplm8JInRmWphgJiXmq1XzeUeZGpH6UnQbMufPLDvs
         Ugwol2mYH94vsvwT+mfdlohDYm3GwZMVbcW4EkiXaB/4yQtTJGonWCrTHGY1HJRK+5wZ
         /BOSrdfwtLq/ETwCjwbzGEQHWzn0xuYznqnkck40l888AQNvhW3pkEFlo0y4k8uyCP1U
         IQykoTE0ZeL/M5E7lSVsP3NsxWG/ddAGBXJjyw/X86QqAobTL4c/862WPR7YWX/o690E
         +DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101517; x=1691693517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjBk32bDKWriayySjcCwFWFBVPsxDvmwmB8EY4pgaXw=;
        b=IU4A8/5XZ0NI+O+JVSrpZvE3s5isTbHB/gDp0Yy/yM6DoWWhhks3JeoKA33g4BQymh
         sf4/MZKdKNP50L1dR/gSKe4TT6Nql1WnVCiREWzXaZ92DteHMuMyV87OHjjTRmw2MaLN
         L63Nu3zyibiOXUEGSyhUXKSbbnmkDOYySENzEPpxL0WFKeIIpYFDU6YSSXlDAl9hHdrw
         qyAqZOuSKkP6AJx93E5YHYZWRe+yhlGeIIarofVSO3Qj2yHUZTS61BNWFHII6y1PcDpf
         6jKIVRjXZ0cWQvdko6frVmlWaXODco9xN4lnG3x6xnk69vzLHIMayQG2JcJU2BVbIlyt
         AvZA==
X-Gm-Message-State: ABy/qLZODamNCK4wgHoYxg1MfDxE8mkYuPnLRIt9r4rTbZ1MNm2jr5wz
	97LJPtvlqkgPCylhVL2l7BDxfb/5TNQhNaFn14k=
X-Google-Smtp-Source: APBJJlE8XDim7Te03Dt/pA8MqjNoZvRsS4Oml9FwbtMa54l7olSwHi+leU4gD7eJcl3XEMTyV70XtHX15865dVcbtz8=
X-Received: by 2002:a05:6402:2753:b0:51e:85d7:2c79 with SMTP id
 z19-20020a056402275300b0051e85d72c79mr3766232edd.7.1689101516775; Tue, 11 Jul
 2023 11:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710201218.19460-1-daniel@iogearbox.net> <20230710201218.19460-2-daniel@iogearbox.net>
 <20230711002320.bp4mlb4at45vkrqt@MacBook-Pro-8.local>
In-Reply-To: <20230711002320.bp4mlb4at45vkrqt@MacBook-Pro-8.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 11:51:44 -0700
Message-ID: <CAEf4BzYYE=ekrkcdM3JY=G1RvDZaUoj1qE2vBcrBfbr8OvmVvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Add generic attach/detach/query API
 for multi-progs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org, andrii@kernel.org, 
	martin.lau@linux.dev, razor@blackwall.org, sdf@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, 
	toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 5:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jul 10, 2023 at 10:12:11PM +0200, Daniel Borkmann wrote:
> > + *
> > + *   struct bpf_mprog_entry *entry, *peer;
> > + *   int ret;
> > + *
> > + *   // bpf_mprog user-side lock
> > + *   // fetch active @entry from attach location
> > + *   [...]
> > + *   ret =3D bpf_mprog_attach(entry, [...]);
> > + *   if (ret >=3D 0) {
> > + *       peer =3D bpf_mprog_peer(entry);
> > + *       if (bpf_mprog_swap_entries(ret))
> > + *           // swap @entry to @peer at attach location
> > + *       bpf_mprog_commit(entry);
> > + *       ret =3D 0;
> > + *   } else {
> > + *       // error path, bail out, propagate @ret
> > + *   }
> > + *   // bpf_mprog user-side unlock
> > + *
> > + *  Detach case:
> > + *
> > + *   struct bpf_mprog_entry *entry, *peer;
> > + *   bool release;
> > + *   int ret;
> > + *
> > + *   // bpf_mprog user-side lock
> > + *   // fetch active @entry from attach location
> > + *   [...]
> > + *   ret =3D bpf_mprog_detach(entry, [...]);
> > + *   if (ret >=3D 0) {
> > + *       release =3D ret =3D=3D BPF_MPROG_FREE;
> > + *       peer =3D release ? NULL : bpf_mprog_peer(entry);
> > + *       if (bpf_mprog_swap_entries(ret))
> > + *           // swap @entry to @peer at attach location
> > + *       bpf_mprog_commit(entry);
> > + *       if (release)
> > + *           // free bpf_mprog_bundle
> > + *       ret =3D 0;
> > + *   } else {
> > + *       // error path, bail out, propagate @ret
> > + *   }
> > + *   // bpf_mprog user-side unlock
>
> Thanks for the doc. It helped a lot.
> And when it's contained like this it's easier to discuss api.
> It seems bpf_mprog_swap_entries() is trying to abstract the error code
> away, but BPF_MPROG_FREE leaks out and tcx_entry_needs_release()
> captures it with extra miniq_active twist, which I don't understand yet.
> bpf_mprog_peer() is also leaking a bit of implementation detail.
> Can we abstract it further, like:
>
> ret =3D bpf_mprog_detach(entry, [...], &new_entry);
> if (ret >=3D 0) {
>    if (entry !=3D new_entry)
>      // swap @entry to @new_entry at attach location
>    bpf_mprog_commit(entry);
>    if (!new_entry)
>      // free bpf_mprog_bundle
> }
> and make bpf_mprog_peer internal to mprog. It will also allow removing
> BPF_MPROG_FREE vs SWAP distinction. peer is hidden.
>    if (entry !=3D new_entry)
>       // update
> also will be easier to read inside tcx code without looking into mprog de=
tails.

I'm actually thinking if it's possible to simplify it even further.
For example, do we even need a separate bpf_mprog_{attach,detach} and
bpf_mprog_commit()? So far it seems like bpf_mprog_commit() is
inevitable in case of success of attach/detach, so we might as well
just do it as the last step of attach/detach operation.

The only problem seems to be due to bpf_mprog interface doing this
optimization of replacing stuff in place, if possible, and allowing
the caller to not do the swap. How important is it to avoid that swap
of a bpf_mprog_fp (pointer)? Seems pretty cheap (and relatively rare
operation), so I wouldn't bother optimizing this.

So how about we just say that there is always a swap. Internally in
bpf_mprog_bundle current entry is determined based on revision&1. We
can have bpf_mprog_cur_entry() to return a proper pointer after
commit. Or bpf_mprog_attach() can return proper new entry as output
parameter, whichever is preferable.

As for BPF_MPROG_FREE. That seems like an unnecessary complication as
well. Caller can just check bpf_mprog_total() quickly, and if it
dropped to zero assume FREE. Unless there is something more subtle
there?

With the above, the interface will be much simpler, IMO. You just do
bpf_mprog_attach/detach, and then swap pointer to new bpf_mprog_entry.
Then you can check bpf_mprog_total() for zero, and clean up further,
if necessary.

We assume the caller has a proper locking, so all the above should be non-r=
acy.

BTW, combining commit with attach allows us to avoid that relatively
big bpf_mprog_cp array on the stack as well, because we will be able
to update bundle->cp_items in-place.

The only (I believe :) ) big assumption I'm making in all of the above
is that commit is inevitable and we won't have a situation where we
start attach, update fp/cpp, and then decide to abort instead of going
for commit. Is this possible? Can we avoid it by careful checks
upfront and doing attach as last step that cannot be undone?

P.S. I guess one bit that I might have simplified is that
synchronize_rcu() + bpf_prog_put(), but I'm not sure exactly why we
put prog after sync_rcu. But if it's really necessary (and I assume it
is) and is a blocker for the proposal above, then maybe the interface
should delegate that to the caller (i.e., optionally return replaced
prog pointer from attach/detach) or use call_rcu() with callback?

