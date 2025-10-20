Return-Path: <bpf+bounces-71447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 826ACBF3A0F
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 23:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6B9D350469
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 21:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBBA2E7659;
	Mon, 20 Oct 2025 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmGEXRnW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF9B27AC3A
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994221; cv=none; b=Mt6qsvwERCPyiim7tOXRomQVkbK7vPCQm+1+XRVuvU045KyOjskhCDg4/gCU/o3Fp/s27X61nTu/Aacq/lUaaI+Ksx77Hu/7Pg00tpIM5R11cRS/z80PfqLZjV+gqZ+5+xlXhzo0XnB+u+y0kwvylcC/Z+0bC0PDuOcUhfSlhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994221; c=relaxed/simple;
	bh=ym62hn5mXbuhCN5hehAcUugUpWeXXFe3OeoR+3Do4YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptUuZb2UoWUUUiBNzy/jpo1Y0zvytpuSco4GDiIl64L8Si8H8L80FX56S3edboYwsm5/6s6TzFAKqumdZAbLUTPK6gOxe85QDWUlosY2fzB8vmsGWNr4on9zpD76Um15mfqECW2cl1MxZzdwQbKGm+mxn0dxYqfol78izhcmbCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmGEXRnW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso4463287b3a.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760994219; x=1761599019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHvm2peGfHbhsKpMKndK4kOnK66ztRAsfccxpN0QFzo=;
        b=gmGEXRnW2y4UCjf+LBMnMeWHCnKJseC8sbrVIt91e9ULse2ne1jVrKYCXjDAWGt7/6
         ubLriocECElqTBskj1GORRNRMFCNzk/WY1x/YfeR3+uJGI9CMHwHLjGdgYIkEt3F2XaG
         AVb48pypz4seCKhUUpgPpPGP6Shco7xIj5Xtt2lCa1RI4CT2tJ0WaujKtXIZwMVpSYPe
         NEpYEuOfqsEO6ITdmD4caENFi+U8lEbKZd9eTcL9h7M3QUQRmT2L4tEiIvjAxYM5WRYG
         tzN/NmQJ5a1Ja6qzsZoONuQ0rqrsZYmBv540u/amyRKyO2aO1FzeqiTf2uC/lTPgK7XE
         vrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760994219; x=1761599019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHvm2peGfHbhsKpMKndK4kOnK66ztRAsfccxpN0QFzo=;
        b=N6/tC341UVLfv5LkZ9tIaRoHjTa/d5pYlurzKVRifbGdOtq+eXueE1Vy6GIccmI5cX
         VzdT5emDGFsFV9XdMlwP3GjDE5ywCPqB9irpMUju32WOcTu8tPt0eF5NAAX25s9k8sNu
         e5+oQ1dRou6UeyFPD9Q+bzgULkwaocW8VuMlTe9xwumZhjx2MH7yI9hK4zUC8S/RKGWx
         MmmY9QR8FRttGKpixrMAmJJDX/hj7RIgGvDL7RrbwvFqmK29rQHgUhi+1PDsHcVBQ6PN
         JlsBpQasxNr+bvmi1kTQ9yYhCBrwdpAaEgaNim18FROeBGpuL/RtLomLnuM0xH8jeZLC
         83vA==
X-Forwarded-Encrypted: i=1; AJvYcCWokNX5uXb4HDcUntcVMQh5rfJjGV2reIvXEtJ4XPn20oUAj6+ZetGQelR8DiwHWLY8N/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZb63CaeMl1NW3gNg3FpLkvlS5AyXd4LcHzAgohz5uB/cVd39
	PtX+PNg0YG/jwyeT5UfpHZcfkaiwln/tSYRDR8NcE6N8czxjD7gLA1D0nma+bALGZ1LlU7f3nW/
	B956n84TNcchb8/VmIHWFBHxx7DAti5w=
X-Gm-Gg: ASbGnctnJdsFjLOlArI50IjtY6fZgsKxgFft8PlY4cvZ5BLcvA4E1DVZBwU7Jdp51XP
	nBV5l+Fnx5U1Yq09fg2lyP1pEvHO1rrIblKuT9uLcA0v8JkCPi+No4TRqs8MxgdI7wsT3qSBf7N
	0lbVigqiPrnqsb+DZHicBQIVoQskh+iv2vsNK96fo0bUr8PJRnkpoRJcKEtStlHW1bM8vjoP8VY
	O5+UO9b0KBW2uGCkL2WmdJLn4Sjc4dHzaVPc/EAuVLRx3koxqQcDOTrQF8S173zxMEASQHdJfa7
X-Google-Smtp-Source: AGHT+IE+hXHVvaHmx33I/a97B/roSrDFnMDMCphJLBkKFgyEe1qKB6887aJg42Ib/tD2MmPmp1av+WgSi3v5raKbhFc=
X-Received: by 2002:a17:90b:4fc6:b0:330:6d5e:f17e with SMTP id
 98e67ed59e1d1-33bcf8faaeamr18286431a91.24.1760994218944; Mon, 20 Oct 2025
 14:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-4-alan.maguire@oracle.com> <CAEf4BzZHS8w8On8W2Ez-r+pmdurw+w=4Yo2bA0fxeYhKhqE7bA@mail.gmail.com>
 <129305e3-adb9-450a-b777-5d42f231c1df@oracle.com>
In-Reply-To: <129305e3-adb9-450a-b777-5d42f231c1df@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 14:03:24 -0700
X-Gm-Features: AS18NWBas2tKlWAwYXS8XfM64jeg4nUvg28GdXvDKiH6XnWTHIPnWDJRS56R_w4
Message-ID: <CAEf4Bza_nnCzn-cOqP170XbqpM2=D5afhnM2Ow_BadmfM8UNXA@mail.gmail.com>
Subject: Re: [RFC bpf-next 03/15] libbpf: Add option to retrieve map from
 old->new ids from btf__dedup()
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:57=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 16/10/2025 19:39, Andrii Nakryiko wrote:
> > On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> When creating split BTF for the .BTF.extra section to record location
> >> information, we need to add function prototypes that refer to base BTF
> >> (vmlinux) types.  However since .BTF.extra is split BTF we have a
> >> problem; since collecting those type ids for the parameters, the base
> >> vmlinux BTF has been deduplicated so the type ids are stale.  As a
> >> result it is valuable to be able to access the map from old->new type
> >> ids that is constructed as part of deduplication.  This allows us to
> >> update the out-of-date type ids in the FUNC_PROTOs.
> >>
> >> In order to pass the map back, we need to fill out all of the hypot
> >> map mappings; as an optimization normal dedup only computes type id
> >> mappings needed in existing BTF type id references.
> >
> > I probably should look at pahole patches to find out myself, but I'm
> > going to be lazy here. ;) Wouldn't you want to generate .BTF.extra
> > after base BTF was generated and deduped? Or is it too inconvenient?
> > Can you please elaborate a bit with more info?
> >
>
> Yep, the BTF.extra is indeed generated after base BTF+dedup, but the
> problem is we need to cache info about inline sites as we process DWARF
> CUs and collect inline info. Specifically at that time we need to cache
> info about function prototypes associated with inlines, and this is done
> - like it is done for real functions - via btf_encoder__save_func(). It
> saves a representation of the function prototype using BTF ids of
> function parameters, and these are pre-dedup BTF ids.
>
> And it's those BTF ids that are the problem. When we dedup with
> FUNC_PROTOs in the same BTF, all the id references get fixed up, but
> because we now have stale type id references in FUNC_PROTOs in the split
> BTF.extra (that were not fixed up by dedup) since we didn't dedup this
> split BTF yet, we are stuck.
>
> There are other alternatives here I suppose, but they seemed equally
> bad/worse.
>
> One is to rescan all the CUs for later inline site representation once
> vmlinux/module dedup is done. That would make pahole much slower as CU
> processing is the most time-consuming aspect of its operation. It seemed
> better to collect inline info at the same time we collect everything else=
.
>
> Another is to put the FUNC_PROTOs (that are only needed for inline
> sites) into the vmlinux/module BTF. That would work, but even that would
> exhibit the same problem as even those FUNC_PROTO type id references
> would also get remapped by vmlinux/module dedup.
>
> So it's not an ideal solution, but I couldn't figure out an easier one
> I'm afraid.

Ok, this makes sense at the conceptual level. This might be useful
overall. But I don't like the implementation, sorry.

The size of mapping "table" is fixed, it's btf__type_cnt(). So just
make caller allocate u32 array of that size, and pass it in. Libbpf
will then maintain/populate provided array with original type ID ->
deduped type ID with an absolutely minimal amount of overhead and
extra code.

so just

__u32 dedup_map;
size_t dedup_map_cnt;

inside btf_dedup_opts ? (and we request user to specify count just to
avoid surprises, we do know the size, but user should know it as well)

>
> Alan

