Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE34E7615
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 16:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359577AbiCYPKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359837AbiCYPKO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 11:10:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C22DBD0C
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 08:07:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c23so8340847plo.0
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uuiuvo5RE0ffBmqMtqFPM+9bv814QszcTACmIhrCvjM=;
        b=nTbhdSLKaFkNh46Kiaf6uYZRujg+VlBbggX9Nh7C687dQykbDPuJLhHbvDrxmerOkL
         jZ8FIIdkeux2f4CHR5IrADRgczTZ2TrMIh5UTI2F/X0t6cvdppxpxsadDidmzBciwlro
         Xrf+ws+lJDLveglDbiuhiyU7iyAFoxi/7/On4o/6go2u+X2NnFMgDSoZtG9IS2+l8HDp
         zAmUZcG9OoiGLthGYkN2kP6pLZYpgRCg9fQf/Ax4VtUIee046Ysn8ZgOac3zYaHDERfd
         75QTJ6zsj2jRnflJL+ETq+iNxxmI7ehnQmzLNWaRNqkdrK1HzzMqw+8RK+glBXVBaztk
         tEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uuiuvo5RE0ffBmqMtqFPM+9bv814QszcTACmIhrCvjM=;
        b=EsnF4WrSpBTzpvqlpp28eUvXT3KVfW8qLEoTwL3ZiT9skiQj6Fj2eFmf5Ni5gOli6B
         C83Dcn1a78N93EGxT367yQiD9AXXFYDam+6pBJ1Dy9dPQP/IYJ4Q6Y5sTV50dxVUqDSI
         EaUkVWZQqx6eYHcwV6L4tkLm+yLgnAoZaelNAforUa3nyus7PpSjnapCGPiRwESR/yJe
         KzsgzvpqkxlWDT8vq/Ez7x8Hs8N7HoO3j9j4JAgHC4TSbs4nkPbRfdueaMi9lrGt1boo
         zGm/Ib88K5GjIm4US4Bub2Q/iKdSJwGfVhEtfyV739vv3wSHdAP7FuAGzkNNd8EskIHI
         Hqhw==
X-Gm-Message-State: AOAM533+yxN9nmNtOOZ92YH/VI2Asg5Jp3fTyE+sHfoe1m7rIdPthLRg
        E3AUiWK2ZC81XXIBgf41CVM=
X-Google-Smtp-Source: ABdhPJz49UBAH6rkfBy4LcVQpHdCA5VydO6Di0dyUUfDsQZNnQ9KXA03J52OcBw01NXwdN33kDbuMg==
X-Received: by 2002:a17:902:ea03:b0:154:4af3:bb5e with SMTP id s3-20020a170902ea0300b001544af3bb5emr12549505plg.95.1648220874491;
        Fri, 25 Mar 2022 08:07:54 -0700 (PDT)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id u10-20020a6540ca000000b0037445e95c93sm5712198pgp.15.2022.03.25.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:07:54 -0700 (PDT)
Date:   Fri, 25 Mar 2022 20:37:51 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 09/13] bpf: Wire up freeing of referenced kptr
Message-ID: <20220325150751.6uybnqtdpf3umcm7@apollo>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-10-memxor@gmail.com>
 <CAADnVQJd8E6T1GRMVS+XZxKDdnMjo-WQ-CdM7+x18VPj9ufpFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJd8E6T1GRMVS+XZxKDdnMjo-WQ-CdM7+x18VPj9ufpFQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 02:40:17AM IST, Alexei Starovoitov wrote:
> On Sun, Mar 20, 2022 at 8:55 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > +               /* Find and stash the function pointer for the destruction function that
> > +                * needs to be eventually invoked from the map free path.
> > +                */
> > +               if (info_arr[i].flags & BPF_MAP_VALUE_OFF_F_REF) {
> > +                       const struct btf_type *dtor_func, *dtor_func_proto;
> > +                       const struct btf_param *args;
> > +                       const char *dtor_func_name;
> > +                       unsigned long addr;
> > +                       s32 dtor_btf_id;
> > +                       u32 nr_args;
> > +
> > +                       /* This call also serves as a whitelist of allowed objects that
> > +                        * can be used as a referenced pointer and be stored in a map at
> > +                        * the same time.
> > +                        */
> > +                       dtor_btf_id = btf_find_dtor_kfunc(off_btf, id);
> > +                       if (dtor_btf_id < 0) {
> > +                               ret = dtor_btf_id;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
> > +                       dtor_func = btf_type_by_id(off_btf, dtor_btf_id);
> > +                       if (!dtor_func || !btf_type_is_func(dtor_func)) {
> > +                               ret = -EINVAL;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
> > +                       dtor_func_proto = btf_type_by_id(off_btf, dtor_func->type);
> > +                       if (!dtor_func_proto || !btf_type_is_func_proto(dtor_func_proto)) {
> > +                               ret = -EINVAL;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
> > +                       /* Make sure the prototype of the destructor kfunc is 'void func(type *)' */
> > +                       t = btf_type_by_id(off_btf, dtor_func_proto->type);
> > +                       if (!t || !btf_type_is_void(t)) {
> > +                               ret = -EINVAL;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
> > +                       nr_args = btf_type_vlen(dtor_func_proto);
> > +                       args = btf_params(dtor_func_proto);
> > +
> > +                       t = NULL;
> > +                       if (nr_args)
> > +                               t = btf_type_by_id(off_btf, args[0].type);
> > +                       /* Allow any pointer type, as width on targets Linux supports
> > +                        * will be same for all pointer types (i.e. sizeof(void *))
> > +                        */
> > +                       if (nr_args != 1 || !t || !btf_type_is_ptr(t)) {
> > +                               ret = -EINVAL;
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +
> > +                       if (btf_is_module(btf)) {
> > +                               mod = btf_try_get_module(off_btf);
> > +                               if (!mod) {
> > +                                       ret = -ENXIO;
> > +                                       btf_put(off_btf);
> > +                                       goto end;
> > +                               }
> > +                       }
> > +
> > +                       dtor_func_name = __btf_name_by_offset(off_btf, dtor_func->name_off);
> > +                       addr = kallsyms_lookup_name(dtor_func_name);
> > +                       if (!addr) {
> > +                               ret = -EINVAL;
> > +                               module_put(mod);
> > +                               btf_put(off_btf);
> > +                               goto end;
> > +                       }
> > +                       tab->off[i].dtor = (void *)addr;
>
> Most of the above should probably be in register_btf_id_dtor_kfuncs().
> It's best to fail early.
> Here we'll just remember dtor function pointer to speed up release.

Ok, will move all of these checks to register_btf_id_dtor_kfuncs.

--
Kartikeya
