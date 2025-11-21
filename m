Return-Path: <bpf+bounces-75211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7945C76BB7
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 01:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1E3C4E322A
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 00:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A74D1EDA0E;
	Fri, 21 Nov 2025 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkp94Goi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21D1AF0AF
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684340; cv=none; b=ZVrbCT2DyAU5P59D3tZRVCQHkw6MuA1DXJXPN13KPSa6zRIyAfMrYH+u731YbyPn7V3u7p40Q4Ouik5hGbUfXoygDg059VEkKAoBHmemj1D/zz9byM9m4byw8LoClqvp/CBlanVAsqto1XsL2DMyavK4XFNiH4wyb4ocaqWQLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684340; c=relaxed/simple;
	bh=W6VN//fI99dnIdVRRfK0Jq0E4qD2aIKWBuCxvBCq9ps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhYBHOIp6akTLAAXIgDMxszSTPQ4WLzo0vbNemMoDtR8cy+pNiblGUNE72uGbvKlXBtr3xRcXkVmpA4FbWZDu3aLK2KIqIVFy9s6fWS8lhD666w3l/h9Adu+K7N+ymhYHHSTwjvTVclL4bppRs/wEgBPMxZFPt5XEX2ZpFsctGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkp94Goi; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bc169af247eso1236621a12.2
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763684338; x=1764289138; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ye5BZK7klyYDAbAE09EZ8XWLEFtAFxFjwr5V3SYrSUE=;
        b=Bkp94Goip0ECROwCiu1PkgvNHYJjJvqr5ZV//tLVP+W4onV1eBLP99AOjowuWwr4Yx
         1060jw2gdikHjKM0B/4pSoR8zSLGR9DzBrd499R77jRpaP90xGwN3EIG+MiKeiYs6WT2
         emzwILMcu0pspXDcvu5tHOyazvFg0rFOsoFJoUb6gKIXZLITEunNg0Rp6tXstmYJlr8+
         v78VbbHE/2TPpzw8BkybNMJ75INEP0Gv043ueTS/Zz20zKloPvCWIRBuha6EilWYywZu
         piKCgOfXuaYdXiO35wnMUXN36+4mK9X2OP8B3pdFPpsIJ39Tm1oU7FfJctdBxZxZnP2u
         4vEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684338; x=1764289138;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ye5BZK7klyYDAbAE09EZ8XWLEFtAFxFjwr5V3SYrSUE=;
        b=wvKeoK2eHqL2wWy2REkJGEqjwFo7a5ZRiQbrYVrlAav9ejzcoyNEQ59RuJZJIrueCY
         qcnHyJ4e/BSrofmQFwy/SHfBhEUAADo/slhiLqwiK0d+uPI4hwAj5sM4crxmhbvM0V0c
         Lfw9dtmF9vDBSbzUVRMg9Adpj89q9mlRgHp1QkqGpPn6fOzavksyBMP0UgFC6lfCL/aV
         uBAFnQ/6VWtOWURuu0mXauCJ1RlMkUuDW1zdQITFTkY50E3K0IG/CckcIyafqdSCE5CJ
         DhZX6GZTi1O9wXn7w1ahsr8PR3AStZ4KSarQwjHFizs2Z8yzYMZGfc8FeYbADnirR1nl
         c3wA==
X-Forwarded-Encrypted: i=1; AJvYcCVU2LwyUfuzp3YRuz7P1/nz/LZviX4V7WIrAcPg8GulceV4jlVuE9ppuo0y5dC+NWftGNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMbO2MSJu8Kbr63eHajXNQ1N8SCH8yXURYYJrr2Rkcrl9QClsB
	0CmQdzIrbBrTipPlW3pujugiTmKtV+wKaT7LLCRJFiM3UTSAfeTwHIVi
X-Gm-Gg: ASbGncvqnhN5i1WId0N3n8M4/KOqUoqMw+0h6eRzDi81cfRk1D3umQPkM2ge8SVIGOf
	ucW/OKdtNdaFUngz+Fi/RQRHnonRrgxx0CRAQH4lSFMqVmkWA3nVlc25XAKtbGET6PzeavJPbV0
	giMiJv3EWBw7LjvOl8F0nrNBoUjScqAPnmy4UxidvWNU7uJ2RExlLecHmuag/DYMMESgRT4cpBs
	WyoCwJUDhBOwA2C7S1wa7w4mhADDJdkPyDXx33YgegTfrQL0iO2hh1QMtO5Hxjt/8lpZ7Ze8sDS
	Pu3t/70iMcYNYrsR9uQ8yBTBA7D3O//VfH7k4UI0LHZDzJ15YZ6N2yfBQudE/WqddJjD/+HT74n
	Niel9lRn2xi3PCiT4OHrYDSe4n5P06DkE7NSgQHA93yik1MZv4cdfkCXXBTLdbiT1YV11M/2Rn8
	NBa9IXOyK0wS7TLSWez8UrPioIfZqvEU4b69OgdWyHt2vS7Q==
X-Google-Smtp-Source: AGHT+IGF5KQsBalboPeueuccCSOB1MdKOGEyds/nUJXJaS+MMOKI7VBRfsbX4cp4Qz9ZSP42vuDvuQ==
X-Received: by 2002:a05:7301:152a:b0:2a4:3593:969e with SMTP id 5a478bee46e88-2a7192a22b4mr122461eec.27.1763684338043;
        Thu, 20 Nov 2025 16:18:58 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6e69:e358:27f9:ac0? ([2620:10d:c090:500::5:61f3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc4f6671sm16143453eec.3.2025.11.20.16.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:18:57 -0800 (PST)
Message-ID: <7c04a6c3010ce41fc7ad0a6b26c94f43dde82593.camel@gmail.com>
Subject: Re: [RFC PATCH v7 3/7] tools/resolve_btfids: Add --btf_sort option
 for BTF name sorting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, 
	andrii.nakryiko@gmail.com
Cc: zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org,  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Thu, 20 Nov 2025 16:18:55 -0800
In-Reply-To: <20251119031531.1817099-4-dolinux.peng@gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-4-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-19 at 11:15 +0800, Donglin Peng wrote:

[...]

> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index db76335dd917..d5eb4ee70e88 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -27,6 +27,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 130) +=3D -=
-btf_features=3Dattributes
> =20
>  ifneq ($(KBUILD_EXTMOD),)
>  module-pahole-flags-$(call test-ge, $(pahole-ver), 128) +=3D --btf_featu=
res=3Ddistilled_base
> +module-resolve_btfid-flags-y =3D --distilled_base
                                  ^^^^^^^^^^^^^^^^
This flag should be guarded by pahole version as well.  However, I'd
suggest not adding this flag at all, but instead modify resolve_btfids
to check for BTF_BASE_ELF_SEC section existence and acting accordingly.

>  endif
> =20
>  endif
> @@ -35,3 +36,4 @@ pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+=3D --=
lang_exclude=3Drust
> =20
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
>  export MODULE_PAHOLE_FLAGS :=3D $(module-pahole-flags-y)
> +export MODULE_RESOLVE_BTFID_FLAGS :=3D $(module-resolve_btfid-flags-y)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 542ba462ed3e..4481dda2f485 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -40,6 +40,7 @@ quiet_cmd_btf_ko =3D BTF [M] $@
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinu=
x\n" $@ 1>&2; \
>  	else								\
>  		LLVM_OBJCOPY=3D"$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHO=
LE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $(MODULE_RESOLVE_BTFID_FLAGS) =
--btf_sort $@;	\
                                                                           =
   ^^^^^^^^^^
                                             Agree with Ihor (and off-list =
discussion with Alexei),
                                             this flag appears redundant. A=
re there situations when
                                             one would like to avoid sortin=
g kernel/module BTF?

>  		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
>  	fi;

[...]

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index d47191c6e55e..dc0badd6f375 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[...]

> +static int update_btf_section(const char *path, const struct btf *btf,
> +				  const char *btf_secname)
> +{
> +	GElf_Shdr shdr_mem, *shdr;
> +	Elf_Data *btf_data =3D NULL;
> +	Elf_Scn *scn =3D NULL;
> +	Elf *elf =3D NULL;
> +	const void *raw_btf_data;
> +	uint32_t raw_btf_size;
> +	int fd, err =3D -1;
> +	size_t strndx;
> +
> +	fd =3D open(path, O_RDWR);
> +	if (fd < 0) {
> +		pr_err("FAILED to open %s\n", path);
> +		return -1;
> +	}
> +
> +	if (elf_version(EV_CURRENT) =3D=3D EV_NONE) {
> +		pr_err("FAILED to set libelf version");
> +		goto out;
> +	}
> +
> +	elf =3D elf_begin(fd, ELF_C_RDWR, NULL);
> +	if (elf =3D=3D NULL) {
> +		pr_err("FAILED to update ELF file");
> +		goto out;
> +	}
> +
> +	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
> +
> +	elf_getshdrstrndx(elf, &strndx);
> +	while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
> +		char *secname;
> +
> +		shdr =3D gelf_getshdr(scn, &shdr_mem);
> +		if (shdr =3D=3D NULL)
> +			continue;
> +		secname =3D elf_strptr(elf, strndx, shdr->sh_name);
> +		if (strcmp(secname, btf_secname) =3D=3D 0) {
> +			btf_data =3D elf_getdata(scn, btf_data);
> +			break;
> +		}
> +	}
> +
> +	raw_btf_data =3D btf__raw_data(btf, &raw_btf_size);

`btf__raw_data()` can return NULL.

> +
> +	if (btf_data) {
> +		if (raw_btf_size !=3D btf_data->d_size) {
> +			pr_err("FAILED: size mismatch");
> +			goto out;
> +		}
> +
> +		btf_data->d_buf =3D (void *)raw_btf_data;
> +		btf_data->d_type =3D ELF_T_WORD;
> +		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
> +
> +		if (elf_update(elf, ELF_C_WRITE) >=3D 0)
> +			err =3D 0;
> +	}
> +
> +out:
> +	if (fd !=3D -1)
> +		close(fd);
> +	if (elf)
> +		elf_end(elf);
> +	return err;
> +}

[...]

