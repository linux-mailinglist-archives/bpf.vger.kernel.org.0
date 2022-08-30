Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A65A6BF7
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 20:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiH3SUl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 14:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiH3SUg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 14:20:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A477A24F39
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 11:20:30 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kh8so9365986qvb.1
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 11:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=v7euC2XHMrmAIDs4GKnYbtV3VOiDosmUFBqV2phdzyw=;
        b=glb0hDfdM5bI/oVd9EIzja+8TNpzsd+7nSGbIgjqt0GnRA/xEbPNCphFoWREpaPEvq
         jIcWy3vTkx0LMZm6yz9Jpod0M59ciYf3n4QTXFOIfmKVFv/gwyGkQ/6DAsR39i/tDLf5
         SeEsJcHCuulnxBs/Unw+VSJ1w1fPP3sCsya8h1rsZMC7DZ09YaZD4oBQqWwfhgCP6tIg
         ZU6dMIi2rQW23uc4/M8+HMKY/+LpCs0pPHkQaGenF2JuCcmrB5AvbBCIZIZeO23T3vAZ
         WKH+wk01VoNvqFJcqVqT+gx3d8qSvbsB/aZ5J7Wmb5p0Qfm97eUH/XSrW+KOUM9WBs5E
         oOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v7euC2XHMrmAIDs4GKnYbtV3VOiDosmUFBqV2phdzyw=;
        b=ZYu5/6GTS75J897zLKqyO0esIDBCViWbZPEkYEXsV8H9MkeDK8Ap8Tv3ZvgioQrBpf
         C80Y6mjPu5iV/9FqRDOeK68H9nvkx2Zzg2HmZowY19njuzAg0j///QQRTsBtbHjdbtIh
         BPsoy+pFQZ/iA6GlbkNKzZy0OiMsLoXOJKyqV3P2psEtmNbSGL7Nl1kwDoH4wc3lnRkJ
         iitoFVbyP8HDyPto2Qjp0Fzhe/mvSG2AxtAMFdMhhaDzWusbqc4Cmz+Hhx7uuTYktFFX
         1wLV22y0kSBBjr22Iak6eYLyN+crWDEc00Rhdeulf7UboIIlPAHnO1MDKlfBGvrh5sUs
         1cqA==
X-Gm-Message-State: ACgBeo1EYVIzKIyPPRrnEzaPIM2kQkTTALSf4DMoQMNI/+LEbXShdaoY
        9etyJSTZNJbZNCMyk4P+cY7ZGoHBM07iCscYtnm4AhRLbd2wtQ==
X-Google-Smtp-Source: AA6agR4Q9dYlXcQynx4E3Xm9Se1fuxtr7KH/CwbjpXc//KNUVTp4Frc/mXJct6oPykLZ2T07iHx3vlnDQagRJ5sj9Ns=
X-Received: by 2002:a0c:b31a:0:b0:473:8062:b1b4 with SMTP id
 s26-20020a0cb31a000000b004738062b1b4mr16537151qve.85.1661883629355; Tue, 30
 Aug 2022 11:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220829231828.1016835-1-haoluo@google.com> <c84fa46d-8f37-c449-06ea-5da795f091e8@fb.com>
In-Reply-To: <c84fa46d-8f37-c449-06ea-5da795f091e8@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 30 Aug 2022 11:20:18 -0700
Message-ID: <CA+khW7jyfAooaiGGuiMU9XZvSUrPvkgi492Rfit32hidtkvw6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpftool: Add support for querying cgroup_iter link
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 9:41 AM Yonghong Song <yhs@fb.com> wrote:
>
> On 8/29/22 4:18 PM, Hao Luo wrote:
[...]
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Thanks Yonghong.
