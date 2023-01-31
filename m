Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C2682C9A
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAaMd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjAaMd6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 07:33:58 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B08029438
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:33:56 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-15f97c478a8so19063809fac.13
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 04:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/aqv/BmUtA6KbSIV6hubnzQltrQ6KSLdr/LeYf53GYk=;
        b=qBvJ8GjpDGgdBv+1aDuPkVrnTf+KlQ9tldFHr2WhJvbrhWPV6PIeJZDVAf2nj+lsS2
         1/L16PzySjzvToTA0/jZByhCbvw7hgs20aIpExT4cZZVTxtLphmqNoh6YDx//fLOiN8F
         eF0f4gf63/45QLMnFe69Aaa2VpOZ2qfyTelalItODFVNfKx2BxJWtMVG2wepvGm6Ld/O
         Lk16q8CEG/sA1zIuoQ3cDPb8qoUFhEWzol52AVIMYxbu3ZwMdPfciuvOFlajobAC6RKr
         j9+S/VX7Oeb2bEN4K0nRnr0pAhLNPQGkY7DJf6is1d9omL6uqVz5NmkmJQKBkS9RnIFS
         2Xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/aqv/BmUtA6KbSIV6hubnzQltrQ6KSLdr/LeYf53GYk=;
        b=GIkXHlPe+yPHAuC6/lA+r5APJi4/r4U5FtcuYdBuVGClA8p3/79PsYtHLXCQ2KUmNP
         cxjn+ZtSccGbjRHMfNCsmh4AA9SLR5XvOe948ebwTLcoatFCjY64rDyKNNXFH0bikZWH
         nZdI2IFnMRvDkX6daonT6S43zMLyCxVhi8NoBPUPODQ7Ycpy3TcX1UfIxkmPkjeQJ8pv
         VemkVT3UZOI/cKMUt+LETcidh8PJo3JKzG+ZByEumKDSRLLAKpIvehiWWoeGmGr7CNE7
         6jgG8jGR95BfP17AlWyVSKuofwhwwvvgh6725w9TadWdiHXgwMZQjMzP4l1hoynjEWTX
         t5pw==
X-Gm-Message-State: AO0yUKVNFammKz9uRpha3qmNVhU7ELiW8bSTCyHwQ/2zTy5VubirkApf
        5xN2t1+ofurSb4ALhkNRvZc=
X-Google-Smtp-Source: AK7set895gdqcqsp83nKox9EH1Qr4olU4npXMeQ4XcZ/UJ+KXClI4PZSEnx8I/ndGitUQEWmMHYOww==
X-Received: by 2002:a05:6870:561f:b0:144:d26f:a77d with SMTP id m31-20020a056870561f00b00144d26fa77dmr7138464oao.25.1675168435499;
        Tue, 31 Jan 2023 04:33:55 -0800 (PST)
Received: from [127.0.0.1] ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id n18-20020a056870971200b0014fe4867dc7sm6445612oaq.56.2023.01.31.04.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:33:55 -0800 (PST)
Date:   Tue, 31 Jan 2023 09:33:49 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_dwarves_1/5=5D_dwarves=3A_help_dwarf_lo?= =?US-ASCII?Q?ader_spot_functions_with_optimized-out_parameters?=
User-Agent: K-9 Mail for Android
In-Reply-To: <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com> <1675088985-20300-2-git-send-email-alan.maguire@oracle.com> <Y9gOGZ20aSgsYtPP@kernel.org> <Y9gkS6dcXO4HWovW@kernel.org> <Y9gnQSUvJQ6WRx8y@kernel.org> <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com> <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org> <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
Message-ID: <F9C1B7E8-7A73-49B2-A2EE-235298D260BA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On January 31, 2023 9:14:05 AM GMT-03:00, Alan Maguire <alan=2Emaguire@ora=
cle=2Ecom> wrote:
>On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo e=
screveu:
>>>>>> +++ b/dwarves=2Eh
>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>  	uint8_t		 has_addr_info:1;
>>>>>>  	uint8_t		 uses_global_strings:1;
>>>>>>  	uint8_t		 little_endian:1;
>>>>>> +	uint8_t		 nr_register_params;
>>>>>>  	uint16_t	 language;
>>>>>>  	unsigned long	 nr_inline_expansions;
>>>>>>  	size_t		 size_inline_expansions;
>>>>>
>>> =20
>>>> Thanks for this, never thought of cross-builds to be honest!
>>>
>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>> defined if using a very old elf=2Eh; below works around this
>>>> (dwarves otherwise builds fine on this system)=2E
>>>
>>> Ok, will add it and will test with containers for older distros too=2E
>>=20
>> Its on the 'next' branch, so that it gets tested in the libbpf github
>> repo at:
>>=20
>> https://github=2Ecom/libbpf/libbpf/actions/workflows/pahole=2Eyml
>>=20
>> It failed yesterday and today due to problems with the installation of
>> llvm, probably tomorrow it'll be back working as I saw some
>> notifications floating by=2E
>>=20
>> I added the conditional EM_RISCV definition as well as removed the dup
>> iterator that Jiri noticed=2E
>>
>
>Thanks again Arnaldo! I've hit an issue with this series in
>BTF encoding of kfuncs; specifically we see some kfuncs missing
>from the BTF representation, and as a result:
>
>WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>
>Not sure why I didn't notice this previously=2E
>
>The problem is the DWARF - and therefore BTF - generated for a function l=
ike
>
>int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>{
>        return -EOPNOTSUPP;
>}
>
>looks like this:
>
>   <8af83a2>   DW_AT_external    : 1
>    <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): =
bpf_xdp_metadata_rx_hash
>    <8af83a6>   DW_AT_decl_file   : 5
>    <8af83a7>   DW_AT_decl_line   : 737
>    <8af83a9>   DW_AT_decl_column : 5
>    <8af83aa>   DW_AT_prototyped  : 1
>    <8af83aa>   DW_AT_type        : <0x8ad8547>
>    <8af83ae>   DW_AT_sibling     : <0x8af83cd>
> <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>    <8af83b3>   DW_AT_name        : ctx
>    <8af83b7>   DW_AT_decl_file   : 5
>    <8af83b8>   DW_AT_decl_line   : 737
>    <8af83ba>   DW_AT_decl_column : 51
>    <8af83bb>   DW_AT_type        : <0x8af421d>
> <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>    <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): =
hash
>    <8af83c4>   DW_AT_decl_file   : 5
>    <8af83c5>   DW_AT_decl_line   : 737
>    <8af83c7>   DW_AT_decl_column : 61
>    <8af83c8>   DW_AT_type        : <0x8adc424>
>
>=2E=2E=2Eand because there are no further abstract origin references
>with location information either, we classify it as lacking=20
>locations for (some of) the parameters, and as a result
>we skip BTF encoding=2E We can work around that by doing this:
>
>__attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struc=
t xdp_md *ctx, u32 *hash)
>{
>	return -EOPNOTSUPP;
>}
>
>Should we #define some kind of "kfunc" prefix equivalent to the
>above to handle these cases in include/linux/bpf=2Eh perhaps?
>If that makes sense, I'll send bpf-next patches to cover the
>set of kfuncs=2E

Jiri?

>The other thing we might want to do is bump the libbpf version
>for dwarves 1=2E25, what do you think? I've tested with libbpf 1=2E1
>and aside from the above issue all looks good (there's a few dedup
>improvements that this version will give us)=2E I can send a patch for
>the libbpf update if that makes sense=2E


Please send it, then we give it some more days of wider testing,

Yonghong, Andrii, comments on updating libbpf in the pahole submodule?

- Arnaldo
