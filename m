Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2846F0643
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbjD0M7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbjD0M66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:58:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8A719AF
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:58:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f19b9d5358so62261335e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682600332; x=1685192332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+pqvpoX8hGLPKKs+BEBG6jvBBSOUyl9ztD88PvqfbnI=;
        b=Io1XoRPO79+yIiuvXLtXXDQk1/G9e2c5F1HaUbFvhXFWeRTuRVkVrLpgTVlkOb3ic2
         Tgra0PNpVDtHTT/+PE6xDrTIctQV4Pi57PK1BMQRkJMBqr8h6WT42AOiUMwtdLXMMsqh
         bN4ocZfnH2PKbyTGOuqVpXGKJC/MQr7ffB99/wBa2jB/ZHtb/IG/8IVeo/OUG5KRv1dr
         U4IU2E54cKJiihZtuTyy0c24UgV7MUadx3eqn0QvnqjUg/yiTnKeAidbgCPCg4g14/fO
         44yptCxJUyggnaF8O/XwwfpwDyty2RTHZp13KE2wTngXZunYBGXqOCTQGgzDmdvLAkvi
         Bx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682600332; x=1685192332;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pqvpoX8hGLPKKs+BEBG6jvBBSOUyl9ztD88PvqfbnI=;
        b=iAPcN5qlflc2jwo5rxCzMLbuPxP3WXxEps0LsHEa/4GvH3wk56wHOyYCBdHUXW/BDF
         71YeP2aJ05QvdYrxuVQvkIPFjZO6QUuvpu6jxsvJJB5FnwRGL+CSZ+6l7vgV1GwGjhpl
         L+WHFnWjPWFOX8LHPMa57ts7GBqwBlFLeU7Df16a3gNo4awzPLOnQhOQyyrDC9uWG5Ni
         rKLbDf0TtpgFaKH98yzyOdyeAmInrbCKMTvY6g6H2Fmq0blJ43G/u0x4C2DpzTKeeCmZ
         Lr4+xHtAgls93ZBW8VEOM9q7Qx3dCKTbyIpQsll/Al8d2FG63z0mISsnhrDYNpce6u2c
         oIPg==
X-Gm-Message-State: AC+VfDxzbFl8VYcvj3d/+e8s5KuMr5tSnw+cCFn5qozJ6u4caWVuS1uA
        fhYXhGJso6RM3oL1TOgjmmQ=
X-Google-Smtp-Source: ACHHUZ46vn0M7Ntg8+9C+rE7MckmRY8G5yQypyg1ohI91+sPORhquxcqoIbW1N56BXI2iv0/E/4vjg==
X-Received: by 2002:a1c:f30b:0:b0:3f1:75d2:a6a7 with SMTP id q11-20020a1cf30b000000b003f175d2a6a7mr1405169wmq.36.1682600332118;
        Thu, 27 Apr 2023 05:58:52 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id w23-20020a05600c099700b003f17af4c4e0sm24486701wmp.9.2023.04.27.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:58:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 14:58:49 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 04/20] libbpf: Update uapi bpf.h tools header
Message-ID: <ZEpxiRt5aSYg/BeL@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-5-jolsa@kernel.org>
 <CAEf4BzZOsy0wC_RFHfJrG9zLjPUa86EencCOZto8FMnOMCpFOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZOsy0wC_RFHfJrG9zLjPUa86EencCOZto8FMnOMCpFOQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:14:18PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 24, 2023 at 9:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Updating uapi bpf.h tools header with new uprobe_multi
> > link interface.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> let's merge this with the original UAPI header update patch? We used
> to split this out for libbpf sync purposes, but it is handled easily
> with current sync script, so no  need to make this a separate patch
> (but up to you, I don't mind either)

ok, will merge it

thanks,
jirka

> 
> >  tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 1bb11a6ee667..77ce2159478d 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -1035,6 +1035,7 @@ enum bpf_attach_type {
> >         BPF_TRACE_KPROBE_MULTI,
> >         BPF_LSM_CGROUP,
> >         BPF_STRUCT_OPS,
> > +       BPF_TRACE_UPROBE_MULTI,
> >         __MAX_BPF_ATTACH_TYPE
> >  };
> >
> > @@ -1052,6 +1053,7 @@ enum bpf_link_type {
> >         BPF_LINK_TYPE_KPROBE_MULTI = 8,
> >         BPF_LINK_TYPE_STRUCT_OPS = 9,
> >         BPF_LINK_TYPE_NETFILTER = 10,
> > +       BPF_LINK_TYPE_UPROBE_MULTI = 11,
> >
> >         MAX_BPF_LINK_TYPE,
> >  };
> > @@ -1169,6 +1171,11 @@ enum bpf_link_type {
> >   */
> >  #define BPF_F_KPROBE_MULTI_RETURN      (1U << 0)
> >
> > +/* link_create.uprobe_multi.flags used in LINK_CREATE command for
> > + * BPF_TRACE_UPROBE_MULTI attach type to create return probe.
> > + */
> > +#define BPF_F_UPROBE_MULTI_RETURN      (1U << 0)
> > +
> >  /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
> >   * the following extensions:
> >   *
> > @@ -1568,6 +1575,14 @@ union bpf_attr {
> >                                 __s32           priority;
> >                                 __u32           flags;
> >                         } netfilter;
> > +                       struct {
> > +                               __u32           flags;
> > +                               __u32           cnt;
> > +                               __aligned_u64   paths;
> > +                               __aligned_u64   offsets;
> > +                               __aligned_u64   ref_ctr_offsets;
> > +                               __aligned_u64   cookies;
> > +                       } uprobe_multi;
> >                 };
> >         } link_create;
> >
> > --
> > 2.40.0
> >
