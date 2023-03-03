Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754776AA4ED
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 23:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCCW5k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 17:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjCCW5i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 17:57:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3766A56508
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 14:57:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s20so5492413lfb.11
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 14:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677884192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dzSXuRXJ7p/rOHJ/sEdI0ptLn68bY6sp0v8gySPgte8=;
        b=q42eZ4ORv3m5M1Q0hW3kmb5tO6yrIgTsaVDtJC37Mnk4UGm6OLNQ9jChyCbFstpAnN
         Am9FV69JWJmHEWqqSnM+up/O5B1EbuVyygL4mtijZw2XdoSQWtPN/aUunAY1vx+iqkne
         7FLEnXQ8+L+MvlswcOwbuTv1bTo83cchzhu/1ylyfZU6WrD7UVXrRcbePujjiYUBFWEd
         QExe8pArzo5zeL1G5vCm1ukmxVo5BvUIeSkWYedwwv65jjgYDAE9Arqbo50EfvLYtYLw
         n9a9fPxhvlYVd248J3NLn1IqZZI6NzzcLQvNgIn665Ofgy6kqH88hPK4ciGl8WGzI+BD
         HGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677884192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dzSXuRXJ7p/rOHJ/sEdI0ptLn68bY6sp0v8gySPgte8=;
        b=TWiyGv1qf8GitSMvLgRvibYpNt3iQQBvioTfaGicL30zpm1LVFQOLV5GDUUaQtPMtg
         rx5dOWl/PWLBj9kz/FeBkOgPUzIryqCOuqQe5gENsHu/SnCbCSy/CA46qnmXl8c6TiVI
         zSIrX+18go7EamXHXPybFB7HgMuFmYyAhV7Gz94KMdY0QhOPCUq0KuE6yT9uF/jI0oAM
         cB6wXdWFWmsqqxpIL5/Zbyz3fOSsIHb63DZrX/0Sxqx36QRu2+TP1GU/GwErP0NUenLL
         NGneqydq2w9LwD3nSZPiklZ4GrqtyB5tW9lwcbt//Rq/sk1cOCLs6s7C7MP2m1WAaad/
         3mfQ==
X-Gm-Message-State: AO0yUKXHXVfXz0R45GbTLOzfVhDSmItUgE4/dKW9X6Bkbk8lxOxl22Jc
        O3hlw9AutidpIAcHRyjxREk=
X-Google-Smtp-Source: AK7set914vp6Wfkf78Wbh8Ni7WEfeB5JLz5V/dnF/HvRyRdzDauH08H2bkjslbxJKXW5Q9LHxEcyLQ==
X-Received: by 2002:a19:ac04:0:b0:4db:18da:1bc9 with SMTP id g4-20020a19ac04000000b004db18da1bc9mr957898lfc.60.1677884192499;
        Fri, 03 Mar 2023 14:56:32 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id w26-20020a19c51a000000b004cb430b5b38sm567059lfe.185.2023.03.03.14.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:56:31 -0800 (PST)
Message-ID: <de93e249059f45d7ca36846ae177c2259cab3919.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: allow ctx writes using BPF_ST_MEM
 instruction
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
Date:   Sat, 04 Mar 2023 00:56:30 +0200
In-Reply-To: <20230303202104.zoldj5z3m35ikkv2@MacBook-Pro-6.local>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
         <20230302225507.3413720-2-eddyz87@gmail.com>
         <20230303202104.zoldj5z3m35ikkv2@MacBook-Pro-6.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-03 at 12:21 -0800, Alexei Starovoitov wrote:
> On Fri, Mar 03, 2023 at 12:55:05AM +0200, Eduard Zingerman wrote:
> > -			prev_src_type =3D &env->insn_aux_data[env->insn_idx].ptr_type;
> > -
> > -			if (*prev_src_type =3D=3D NOT_INIT) {
> > -				/* saw a valid insn
> > -				 * dst_reg =3D *(u32 *)(src_reg + off)
> > -				 * save type to validate intersecting paths
> > -				 */
> > -				*prev_src_type =3D src_reg_type;
> > -
> > -			} else if (reg_type_mismatch(src_reg_type, *prev_src_type)) {
> > -				/* ABuser program is trying to use the same insn
> > -				 * dst_reg =3D *(u32*) (src_reg + off)
> > -				 * with different pointer types:
> > -				 * src_reg =3D=3D ctx in one branch and
> > -				 * src_reg =3D=3D stack|map in some other branch.
> > -				 * Reject it.
> > -				 */
> > -				verbose(env, "same insn cannot be used with different pointers\n")=
;
> > -				return -EINVAL;
>=20
> There is a merge conflict with this part.
> LDX is now handled slightly differently comparing to STX.

I changed save_aux_ptr_type() as below:

  static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_t=
ype type,
  			     bool allow_trust_missmatch)
  {
  	enum bpf_reg_type *prev_type =3D &env->insn_aux_data[env->insn_idx].ptr_=
type;
    ...
  	if (*prev_type =3D=3D NOT_INIT) {
        ...
  	} else if (reg_type_mismatch(type, *prev_type)) {
  		/* Abuser program is trying to use the same insn
         * ...
  		 */
  		if (allow_trust_missmatch &&
  		    base_type(type) =3D=3D PTR_TO_BTF_ID &&
  		    base_type(*prev_type) =3D=3D PTR_TO_BTF_ID) {
  			/*
  			 * Have to support a use case when one path through
  			 * the program yields TRUSTED pointer while another
  			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
  			 * BPF_PROBE_MEM.
  			 */
  			*prev_type =3D PTR_TO_BTF_ID | PTR_UNTRUSTED;
  		} else {
  			verbose(env, "same insn cannot be used with different pointers\n");
  			return -EINVAL;
  		}
  	}
 =20
  	return 0;
  }
 =20
But I don't understand why is it allowed to dereference untrusted
pointers for LDX but not for ST/STX.
 =20
[...]
