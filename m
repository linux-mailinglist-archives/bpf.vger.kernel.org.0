Return-Path: <bpf+bounces-273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0B66FD648
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 07:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BE52813C1
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCC5670;
	Wed, 10 May 2023 05:39:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446B20EA
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 05:39:13 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F9E5B8A
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 22:39:02 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-61946c27e58so32872586d6.0
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 22:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683697141; x=1686289141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oem0+c3YcMxZ3Gb939OVSJypNCGCdW4Tu4a0seBtyd4=;
        b=cHi9DrwgrsLW+izQOieGzCk+qLzGBUNQjagvEXyWn4Q9p6Y3HtZltjOFvoc2Yjcb4A
         /QEOBjcJFtHyZjEOemrJEZQQsH/X+Hx9AOv+JJUVUiVRl3vgMcE4beq65+Gezo3RPhu9
         eWhomh0jSD+vqlu7N9J+hKlBoBG/mV2YmN/1XVv3KuH8k3w3UmT8vcQnr6HeMhPdkxP5
         81TMd3xeBdJJcOefuw0EF2zLtM9DdjzyfCPOtn4qkUpJO/6/Gj4Vqf75Jg33z0aCX0X7
         j3ghH5kJ8Kz/TXk6/T0e3zWDh+B4LN+k0piKnECRruEmJWaFACWIVA1HQ3orYVIt/huo
         LP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697141; x=1686289141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oem0+c3YcMxZ3Gb939OVSJypNCGCdW4Tu4a0seBtyd4=;
        b=W1aBSWniT7vlBRELi13KPfSM/80q1P73M4piqgDusnS73mICC3hc483GjlwcmJoqVw
         vC3pghB3lvZLCOG6/h8wBBFEnDgQnIwvhxVwFL2/hr0xncWXt82IWBdqQ2HiIEekAURj
         Hqo+4IuCM9K5gj7YIljIIOaTKiEOFfeRQmys8WELdgZpmiEM+Y1zjxTrGolGEbfbPXPC
         zIah5w0GpnEhRu8pX9DZg9T5/aAuFPwpe1tEmvorBwDwgZvehY/dw1pzLyoRjSYhCL4A
         w3tm1yGN0ltkQogk123F9m4KJQoOMHUbsU6g4rohl/xD+06pYIuBw76FKDgBLdXfglyW
         ocag==
X-Gm-Message-State: AC+VfDy6SH5j3EMNGaD1bpoKndN/bUtxSO3LhOZNE0C5LwgmA090DDGL
	Cl67ZfvABrKc44Rw+Oecj0pWxxRXXInLk8cpu6o=
X-Google-Smtp-Source: ACHHUZ5gw7BIoAQVaAX2DoaXc+6TTHpQBqtT8yJIv2VFLqat6MO4M1C+ch+XuF12NXEznBRuA9DysTIzfvhhFUqDW2g=
X-Received: by 2002:a05:6214:d04:b0:5bf:ba9d:8726 with SMTP id
 4-20020a0562140d0400b005bfba9d8726mr24242346qvh.10.1683697140884; Tue, 09 May
 2023 22:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230424161104.3737-1-laoar.shao@gmail.com> <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
 <CALOAHbAnGLYV9H2t=4rHxdmXwUhXbsUEvK5-MLPq38JkUR8jGw@mail.gmail.com> <CAADnVQKuaKwfwPvt3ffi3Gkzsq=9Oj=tnb6Ya1O0EX5uApQg7w@mail.gmail.com>
In-Reply-To: <CAADnVQKuaKwfwPvt3ffi3Gkzsq=9Oj=tnb6Ya1O0EX5uApQg7w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 May 2023 13:38:24 +0800
Message-ID: <CALOAHbDdm-wLJ+eWzWza3wED4LuwxnE9bf2ssGhNgZjgkE82jw@mail.gmail.com>
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 1:18=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 9, 2023 at 8:36=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Tue, May 2, 2023 at 11:40=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > Alan,
> > >
> > > wdyt on below?
> > >
> >
> > Hi Alexei,
> >
> > Per my understanding, not only does pahole have issues, but also there
> > are issues in the kernel.
> > This panic is caused by the inconsistency between BTF and kallsyms as s=
uch:
> >    bpf_check_attach_target
> >        tname =3D btf_name_by_offset(btf, t->name_off); // btf
> >        addr =3D kallsyms_lookup_name(tname); // kallsyms
> >
> > So if the function displayed in /proc/sys/btf/vmlinux is not the same
> > with the function displayed in /proc/kallsyms, we will get a wrong
> > addr.  I think it is not proper to rely wholly on the userspace tools
> > to make them the same. The kernel should also imrpve the verifier to
> > make sure they are really the same function.  WDYT?
>
> Are you saying it's not proper to rely on compilers
> and linkers to build the kernel?
> pahole, resolved_btfid, kallsym gen, objtool are part of the
> compilation process.
> The bugs in them are discovered from time to time and
> have to be fixed. Just like compiler and linker bugs.

I was wondering if it is possible to add BTF_ID into kallsyms or to
add function address into BTF. Because the function name is not
unique, while the function ID is unique. So with the function ID we
can always get what we want.

For example,

$ cat /proc/kallsyms | awk '{if ($2=3D=3D"t"||$2=3D=3D"T") {print $3}}' |
sort|   uniq -c | sort -n -r | less
     56 __pfx_cleanup_module
     56 cleanup_module
     47 __pfx_cpumask_weight.constprop.0
     47 cpumask_weight.constprop.0
     21 __pfx_jhash
     21 __pfx_cpumask_weight
     21 jhash
     21 cpumask_weight
     17 type_show
     17 __pfx_type_show
     14 __rhashtable_insert_fast.constprop.0
     14 __pfx___rhashtable_insert_fast.constprop.0
     12 __rhashtable_remove_fast_one.cold
     12 __rhashtable_remove_fast_one
     12 __pfx___rhashtable_remove_fast_one
     11 __xfrm_policy_check2.constprop.0
     11 __pfx___xfrm_policy_check2.constprop.0
     11 __pfx_modalias_show
     11 modalias_show
     10 rht_key_get_hash.isra.0
     10 __pfx_rht_key_get_hash.isra.0
     10 __pfx_name_show
     10 __pfx_init_once
     10 name_show
     10 init_once
      9 __pfx_event_show
      9 event_show
      8 __pfx_dst_output
      8 dst_output
      7 state_show
      7 size_show
      7 __pfx_state_show
      7 __pfx_size_show

kallsyms_lookup_name() always returns the first function and ignores
the others, so it is impossible to trace the other functions with the
same name AFAIK.

--=20
Regards
Yafang

