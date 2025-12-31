Return-Path: <bpf+bounces-77624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14189CEC711
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 19:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4627C302219C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9E2F7444;
	Wed, 31 Dec 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eMIZNaZx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F492BD586
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204574; cv=pass; b=oXIeRX4fHbzlEodD80Ko2oxL7KT8x2Phko8fBHO/M4j8I9Se+6Zpi6PBYvx/2WgY5WGGWSsycv5BdWoBEuPQvsjkGzh2FTs02VGpoFNus0cDZkIJ9y2kwMgCEau5aXLXBObnXwVMogWXsKod+P3zk5K+cbz+5tJQIW0onlQL6O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204574; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH15ZkcOrEYdHBW6BOVNQTUcPDWloPjGZ0qB/je7GXSjIKiLqp1X5+eMRjx68uj6v8atCWKHhftGPp92rIKAxtXkjgKLwC0ewBGpjV9rNX8M1tqlZtblT9tG/pkr8L8kcYwGpmjJBCvp/Pu2SsyseRyz4rsj3wH7FAmANDOubBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eMIZNaZx; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so436996a12.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 10:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=Y/S0vhpxoywgAqdaYyPZIzYwd8/puUE1VhZpaByCbSulv20sxXT6JV3T7FN/8HGB+n
         THS2+Ipy0jyocavXVhJewqxK9Kojou/6cVyQ/9wOwAasNgbqE+4AayxQtZyTrMWQEcHc
         dXldCrm37xbzDfsYANEO/OjM4dcMPXxX0cpqjyP/HdRaXD0WAW6R40X359UyRvv0C98X
         oCrFGCylJcUNr5XbmnVowTCfq8POU7CCJljDoz3Y2Mhkxe1gTMoyxG4eV/N9Eg5OjO4+
         VMXOOeNzpI++y3XG8J/7hX/c1RhGMRloNGuAvas+JPSutK6eNnDssmoheYmlnz/Kabti
         nQGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=w+fcE320VAhTxFzpHqZPFXbSdGxjQvt437HhDBM/DAU=;
        b=Jx7Wu6vRwUd76NK1n67yb8SG0GVlyoROmIKp27UDfz7JUdaUc1dc+Kz55cUUd77WiM
         rMZnTBkDkEtUdiOWBwNmXmyItbNUWmKcGcYOUGGDdvbhFydtlTXGWtlWg51DjPHNkq73
         vtuCC2KFTgeHoUqi9toagEPAqEuFTgrfP1WGaotjwJTHdutG8Rfv/OJ+ugCDm0N1GxaX
         aG07Zz5cjg8XtdaY79K52NrMS5O+NdEkFSL2q/qyJpjWr6OVI3N07xImQIL80oCHLeBs
         RFKYLaB7GCKtGS2CcQpd34dbpUts4URa9bIwFpZ6PRp6gMCeLCRUcaqNCIJqWkl+ENxD
         2J1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=eMIZNaZxBhjFWbRV5ha9XKWe6+Thr83KYVjbX2EkOS0ijkIS/ouyjp0CtYoTRWnilM
         e58ePoaklivu0fQntxNqGZw9WUotToDYHEVdITkDaRpzEbVk0cI4e+0WXxKdC9aGjZJj
         JgFBFp0fhc6aUWuQCuIWhwiQ4wMayISpnxgDrXkOgMY16odAXqHr9AANLOBFS7j+6a5F
         fJO0q61tAgcea0PhgKSTCegLBw7cy5T1i8LarrJq8r33fGcLXBobunY3aVGko+6xOKhS
         RkYLDJqwAvKBEaH/S64IIxntuSDjfWqmS+f7PwuwiOI+FcPy3dSnealEdllqritOeNLy
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=IdR5a6ytQClFlYWwDhfedANep0vBPNHI00FUONC8I/LKJl1Zsb7h48vlMRgj+ZTW6C
         kSnrc5WVUKdmi1PpTPS0KA+sZClDfwAoXb0VY6HkxWxclWsC2bX/EckwgDRDTzB53G64
         jQmUo1GedbZbSC8Sy7Y/isaAoPz+IJ8A6+Z8dBMncBse9ceYA2BcInsmBQ98SopcV5Dv
         TJGirck9xUwrHJsPJTmfH9kwJDJ9TltQRbCpzgJc7sWcO2AnX4VVRP4i+TeGYykmxoSH
         BTgwjHQuzLvzVlJFX81XbQBWJues1btJnPiY6WFtoZqtbpFlN7+bKBsFazIhNjONsILv
         KVbw==
X-Forwarded-Encrypted: i=1; AJvYcCXU+zPGl1830rt7cNR3VZ0fuHENFxlVt3Xffm+z0vwxUg6AZA7ojh4jTjs1+Eve48fZL1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmhpTp1zXU4QnzePeo/VLxpPQ1lV1ehMiibSKwfhPgkIxVNQI
	X9fEwv9FnuneSkIVhHiDrEz4YhfAiS1uquZAu/dxMTlhPUm7rncPK5QjT3NuS2LZiBtFLbReO3V
	1sRLpA3Kn8JqRevBSW7WAJ8DTM9W8gVAcuFiFnH5pew==
X-Gm-Gg: AY/fxX6IBl2UZpAyQEi6GjlJFW1hCWOo/XBFOcpfZ1TPNvgvEaIyG9p1g7Zhibd2HNY
	pVu48s6DyAZptC6pmmFC8SZzOtk7EyfjEA+T5oDbeMJGSukoFubZDHpHxilZuq8w6xaMhZpjQzT
	cYO9MzyzVBrYB82AxSvyjeKBXRsri0e9UiprlfymnirBiKUP4MsHCLLLFBQq0UcCg6nFy+SeINo
	mwpKQFurcGHmxKFJ8OxrQkMlczRWpaEgnAhAyyEBLDtbFzqGNNbbD7gtdCXci4DnQfFlec0o2h2
	SabgvUQ=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229

