Return-Path: <bpf+bounces-72380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A399C11DBF
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 23:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F61A65837
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F172D97AA;
	Mon, 27 Oct 2025 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJMpfckN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB52F12A3
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604690; cv=none; b=pAIeWu7E3Xdlq1speOYepOeM7yae9ozgQ3HWBb0mSoEvTYTSw6gTeX/eLo3hGimm9xVSh9rwEUw0zWcTDVP56KCPhWL7Mqrga7Sphc0aJCerHNNPkFfAITwjtAfALtzVKvPuKgD3DIY89e2+53Zaq6wmhRgLyoVa197S2Glp5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604690; c=relaxed/simple;
	bh=8LyPPjguGNSVJlKG5jajc4g92mACZiPqAPv6ykSyQ+k=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B855ddWhkK02F9dz2XXhUAlOUsb/W3FxahfMZoRh+0Y6AQmn/o8PsnzE7zgWqMIWZ5Tp4ZLRIRAHDsWtdUqlKuvzNcgzWGfM+yLdl3aD7gkCjpoW5oC95V0Putdy3QcxiDMeZG6VccHfMqRu474DdpaNnGEVMEV0k8kjDW5INlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJMpfckN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340299fe579so327866a91.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 15:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604687; x=1762209487; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EedtdqTCYCQ+1n66kbJzMRTpMmg1X7TIaVHz7291L6Y=;
        b=NJMpfckNoyH6JDl1cydtYtBZA7K9+BmO/BdsbOTJoZNGz/64MSF4bpIEqAYS7WFAKk
         ul1iW93kfrskmoou4fgQ19n3tHGlMNUq52Mkf0wlCr5g1eLdzfrKJmLch8LJNlnGulcn
         KcW3nq1zLfEcM9pWtrK+FCDRCIhgQEitHgHEfGHZcXlSMCHHd47Qi/ARd95iZc6D4+W2
         JVt+K49RoTs4FowTEzeiJn8bpgFdX4WVmVMUQr3u9xDy3A1gdl2B/D4LvC97MpC/xxVI
         nN6rD/IbD4vVem2mt5J1GklKeplBuf0b7r1qt1RwryfGpHMtjnsoJqwuRVowha7AXamD
         pMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604687; x=1762209487;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EedtdqTCYCQ+1n66kbJzMRTpMmg1X7TIaVHz7291L6Y=;
        b=N2kSKPGAGSWTTMFlrnhFJo8Bz7tXBak9TIPEVCBeRkZPQH7+7Gn26KUW+0e/+u6X90
         3q6e5gerZpvBQ7p1Oe+J1WpXKOX4o+RKeufIL4Icusvr8JdwJsYkROvnLNzn28ghTmmd
         zaRJxmD1AznHl7lXIY9Ul1bqRmRh5rqOj5NWaCZ4Q4F5SoeQM5naHDG2HALDpysK0AjL
         EknPcw4j02YO1k/Sgnj0J8FSLV60Oz4F4/L1zAnfmI9zFo1YhhmTidRoH7fq08oI1j20
         TVHCB6gxe+0TnfJJA+um3xe5Ux/exjUI+ruzBxp/wcgdVGcPBgnmFfvVXThqGqXygXyJ
         9GOg==
X-Forwarded-Encrypted: i=1; AJvYcCUi3wrgDdsTfjO54ikCm+QtE2rrCxC30hNOl8Gvy0v84z53xyc2yZNnFndRIkyh7UKMXw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwqYQPbmgfrgEpjf/nDMj4WIvyrWJV7Ht1DcOVJJaapbt3zib
	0XEg/0lqFU69AYtyUtYYBFP42vHhKq5rEK2fSDDvHC95pDA2ITxEwKNR
X-Gm-Gg: ASbGnct+BhU6OnXxyIQovFnxBlFM/ikSNOqPrdF5s75in6e2W9I8pcgkPZwO/0wEh7w
	db1nIDYhM53O83wJXFLQcCgWSj5/XMCh2mAbuBlfK1iES1rDEVyy5aKJIou91WK4Xpz/f5blt9d
	i5zvQ0FCM9VkzGaJgyBfufGohnqEjn62AHz+HWwbTyquj487UCI5NxqoayBv+QHnKD0ADb3mAce
	QTOACfPCK4K8ayDrwUCsN8U432vuyOy2T3UXNeMItCY27JxVamifC+2T96YTqApAc2dPjfUXhGz
	OMys+6Wl+F+1/gdY8yTR1kW6gXtgai27YdIHtA2GzcuUcds1TZn4fgr9tyic9tEL1QEsWolNg2r
	8pLIJVmO5OZ7BxdgCt2FNkJvmKpDhP3HkJaajTsd23gTY3yRx7V4i+n4A7PDIZdQ1Q4TEWJtqv0
	tHrB43QSye
X-Google-Smtp-Source: AGHT+IEBZW1NP9hem8lcOd6TNAJAaCJn7TRzDTDehGydchEg8Q8ARaWKHqJREp2zz1YuEYyOkbrg+Q==
X-Received: by 2002:a17:90b:4b11:b0:32e:87fa:d975 with SMTP id 98e67ed59e1d1-34027ab3922mr1488840a91.34.1761604687473;
        Mon, 27 Oct 2025 15:38:07 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340299e6fe2sm301739a91.0.2025.10.27.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:38:07 -0700 (PDT)
Message-ID: <dd184cdb0593392c6ad6c19111bfa17ac56bcb1f.camel@gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Mon, 27 Oct 2025 15:38:04 -0700
In-Reply-To: <20251026192709.1964787-10-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
	 <20251026192709.1964787-10-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

[...]

> +static int create_jt_map(struct bpf_object *obj, struct bpf_program *pro=
g, struct reloc_desc *relo)
> +{
> +	const __u32 jt_entry_size =3D 8;
> +	int sym_off =3D relo->sym_off;
> +	int jt_size =3D relo->sym_size;
> +	__u32 max_entries =3D jt_size / jt_entry_size;
> +	__u32 value_size =3D sizeof(struct bpf_insn_array_value);
> +	struct bpf_insn_array_value val =3D {};
> +	int subprog_idx;
> +	int map_fd, err;
> +	__u64 insn_off;
> +	__u64 *jt;
> +	__u32 i;
> +
> +	map_fd =3D find_jt_map(obj, prog, sym_off);
> +	if (map_fd >=3D 0)
> +		return map_fd;
> +
> +	if (sym_off % jt_entry_size) {
> +		pr_warn("jumptable start %d should be multiple of %u\n",
> +			sym_off, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	if (jt_size % jt_entry_size) {
> +		pr_warn("jumptable size %d should be multiple of %u\n",
> +			jt_size, jt_entry_size);
> +		return -EINVAL;
> +	}
> +
> +	map_fd =3D bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
> +				4, value_size, max_entries, NULL);
> +	if (map_fd < 0)
> +		return map_fd;
> +
> +	if (!obj->jumptables_data) {
> +		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +	if (sym_off + jt_size > obj->jumptables_data_sz) {
> +		pr_warn("jumptables_data size is %zd, trying to access %d\n",
> +			obj->jumptables_data_sz, sym_off + jt_size);
> +		err =3D -EINVAL;
> +		goto err_close;
> +	}
> +
> +	jt =3D (__u64 *)(obj->jumptables_data + sym_off);
> +	for (i =3D 0; i < max_entries; i++) {
> +		/*
> +		 * The offset should be made to be relative to the beginning of
> +		 * the main function, not the subfunction.
> +		 */
> +		insn_off =3D jt[i]/sizeof(struct bpf_insn);
> +		if (!prog->subprogs) {
> +			insn_off -=3D prog->sec_insn_off;
> +		} else {
> +			subprog_idx =3D find_subprog_idx(prog, relo->insn_idx);

Nit: find_subprog_idx(prog, relo->insn_idx) can be moved outside of the loo=
p, I think.

> +			if (subprog_idx < 0) {
> +				pr_warn("invalid jump insn idx[%d]: %d, no subprog found\n",
> +					i, relo->insn_idx);
> +				err =3D -EINVAL;
> +			}
> +			insn_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
> +			insn_off +=3D prog->subprogs[subprog_idx].sub_insn_off;
> +		}
> +
> +		/*
> +		 * LLVM-generated jump tables contain u64 records, however
> +		 * should contain values that fit in u32.
> +		 */
> +		if (insn_off > UINT32_MAX) {
> +			pr_warn("invalid jump table value %llx at offset %d\n",
> +				jt[i], sym_off + i);
> +			err =3D -EINVAL;
> +			goto err_close;
> +		}
> +
> +		val.orig_off =3D insn_off;
> +		err =3D bpf_map_update_elem(map_fd, &i, &val, 0);
> +		if (err)
> +			goto err_close;
> +	}

[...]

