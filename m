Return-Path: <bpf+bounces-18650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0181D653
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 20:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5DFA1C20F2C
	for <lists+bpf@lfdr.de>; Sat, 23 Dec 2023 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791B1401B;
	Sat, 23 Dec 2023 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="HICU32Ne";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MVrU9f+m"
X-Original-To: bpf@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BAE15E93
	for <bpf@vger.kernel.org>; Sat, 23 Dec 2023 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 339EB3200A64;
	Sat, 23 Dec 2023 14:35:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 23 Dec 2023 14:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703360135; x=1703446535; bh=zAyT+yvmUD
	TKT9+BLALajdObfCH9/4L3ECZLQAfOpV0=; b=HICU32NeAF08kz0KQg7qVGmop7
	M8nUbukXcyVHKrA2J2JKOnJNVO68Z7Tl3qQSP0RX07AnxKDdkxIGa4YIIOg70bsV
	HZ2gNMShubB5iKtJEJPwuajkea/3NTX9jDIp+2KVS6U9GNq1J2WMiILbID5/NB75
	BHW22saFGN50OEcIIIEhhjdiw+jFUpcQXE3bcAvFVkUmo9fJaYJ4JTXs2FHebFXj
	NZtDd8Oqkl7i0TrZKFpl44wU44RLX20XvkHe/82+0kocppIRPccs7WpUya+T5au5
	xOeGKd/7E1Mk8xiV9fmBxloemVCHORV+Hnz7nqnUN2GEPAofHHakc+EYcLtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703360135; x=1703446535; bh=zAyT+yvmUDTKT9+BLALajdObfCH9
	/4L3ECZLQAfOpV0=; b=MVrU9f+mitVP5o/M7sK7nhcio/sebFnVcuWFUwazmKU4
	e+7vACO+YY7mmklhEtQUT86KHJ8POETxsSyg/4DMbHCjRjK3nNM9LT+I8ewZRDU8
	ISdb8h8fxZOnYhLCx1rEvhBJc+EIgQ3gmQd/UuKi0PdCWp2fa67mkt3uqVdA/aTy
	zwhwXPJ0peD6EYNpYSfUhxn+Cl+E7ho22p3zSnhI9GNoNXByHFW6+3fhlNRoSdhT
	8NIEkTu8m9PSAFRS+6SzEKxOwVzcw+CgFoBRlI/1hF4QR+LMBpHgm4625TvtilTi
	asvaEkQFFDMJD6+vvICEJD6cId32Scu+HFwnGm/iCw==
X-ME-Sender: <xms:hzaHZWpvd0mpm4x5OeBvYWXEQa0cltF1RJ0MjD_1dSS9MGJnVqTewg>
    <xme:hzaHZUrIoX8IrX5svtk_b3L6x8I0v3nuuuEiilSptoI0IMXM32qi7PAr7M4e_Hf5A
    0nwc0dt64QayO8TJA>
X-ME-Received: <xmr:hzaHZbMbbXkgtIPZQVtiWd0PnlYq0v8rGcsApPnrHn82n19p_VAViEtRvP3TkYN28JylDAhhWBNO6PM9WqKFWDlPftQFQoUdl-xNf88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduledguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:hzaHZV4JP8KwkAbe1Ff5SWwi0IMU0qQbouWHKhIbujxIiTJ93iIfZA>
    <xmx:hzaHZV41LbqnxJQfmGCgnYN9oxWIquzx9UuNbzaNAGJXC_DpqXI-kA>
    <xmx:hzaHZVjJwBpa0VjVUtS9tl7Nq7FQ6HYT48jxGOl4eSI_waGkJV9Zyg>
    <xmx:hzaHZTSc1PsgmZcmVRXdsWJBdZBwmEeWNQNAu2tNLvF9jLP-SI0bug>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Dec 2023 14:35:34 -0500 (EST)
Date: Sat, 23 Dec 2023 12:35:33 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves] pahole: Inject kfunc decl tags into BTF
Message-ID: <msb3iw5egftixy726ppaz3r2zaiwqyvxwvisimwomehtwi7vza@w73aih4ueju3>
References: <421d18942d6ad28625530a8b3247595dc05eb100.1703110747.git.dxu@dxuuu.xyz>
 <ZYP4yK4qg2iJfTSx@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYP4yK4qg2iJfTSx@krava>

On Thu, Dec 21, 2023 at 09:35:20AM +0100, Jiri Olsa wrote:
> On Wed, Dec 20, 2023 at 03:19:52PM -0700, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> > 
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> > 
> > Example of encoding:
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg DECL_TAG | wc -l
> >         388
> > 
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 68940
> >         [68940] FUNC 'bpf_xdp_get_xfrm_state' type_id=68939 linkage=static
> >         [128124] DECL_TAG 'kfunc' type_id=68940 component_idx=-1
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> SNIP
> 
> > +
> > +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
> > +{
> > +	int nr_types, type_id, err = -1;
> > +	struct btf *btf = encoder->btf;
> 
> could we store the kuncs in sorted array (by name) and iterate all IDs
> just once while doing the bsearch for the name over the kfuncs array

Ack, will take a look.

> 
> > +
> > +	nr_types = btf__type_cnt(btf);
> > +	for (type_id = 1; type_id < nr_types; type_id++) {
> > +		const struct btf_type *type;
> > +		const char *name;
> > +
> > +		type = btf__type_by_id(btf, type_id);
> > +		if (!type) {
> > +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> > +				__func__, type_id);
> > +			goto out;
> > +		}
> > +
> > +		if (!btf_is_func(type))
> > +			continue;
> > +
> > +		name = btf__name_by_offset(btf, type->name_off);
> > +		if (!name) {
> > +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> > +				__func__, type_id);
> > +			goto out;
> > +		}
> > +
> > +		if (strcmp(name, kfunc))
> > +		    continue;
> > +
> > +		err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, type_id, -1);
> > +		if (err < 0) {
> > +			fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> > +				__func__, kfunc, err);
> > +			goto out;
> > +		}
> > +
> > +		err = 0;
> > +		break;
> > +	}
> > +
> > +out:
> > +	return err;
> > +}
> > +
> > +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> > +{
> > +	const char *filename = encoder->filename;
> > +	GElf_Shdr shdr_mem, *shdr;
> > +	int symbols_shndx = -1;
> > +	int idlist_shndx = -1;
> > +	Elf_Scn *scn = NULL;
> > +	Elf_Data *symbols;
> > +	int fd, err = -1;
> > +	size_t strtabidx;
> > +	Elf *elf = NULL;
> > +	size_t strndx;
> > +	char *secname;
> > +	int nr_syms;
> > +	int i = 0;
> > +
> > +	fd = open(filename, O_RDONLY);
> > +	if (fd < 0) {
> > +		fprintf(stderr, "Cannot open %s\n", filename);
> > +		goto out;
> > +	}
> > +
> > +	if (elf_version(EV_CURRENT) == EV_NONE) {
> > +		elf_error("Cannot set libelf version");
> > +		goto out;
> > +	}
> > +
> > +	elf = elf_begin(fd, ELF_C_READ, NULL);
> > +	if (elf == NULL) {
> > +		elf_error("Cannot update ELF file");
> > +		goto out;
> > +	}
> 
> SNIP
> 
> > +		}
> > +		free(kfunc);
> > +	}
> > +
> > +	err = 0;
> > +out:
> 
> leaking fd and elf object (elf_end)

Good catch thanks. Been writing too much rust...


Thanks,
Daniel

