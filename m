Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BD759EE61
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 23:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiHWVpV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiHWVpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 17:45:20 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E4C6A49F
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 14:45:19 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso15341940pjd.1
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 14:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0GMlhckD8lA0tBGGX9NXupfe37WIoUs0Ssud0Kl00eM=;
        b=gSi/DMzr97xIxJz0W5RwdP1ApZAUpEoE1o/6GNpfgOaHRPXEKCIV4XEJx2J3myrwWq
         i8ThvvXPglN5Dj8eLTkHU903ygzDFbh9ytfbyplbvGyIVLi9cVq+/N59lGrHqkkV9jJv
         YDBHJokCiiTURQugJstvm+p+J49kdqnSbSMwPbQ+q3DTUpQAqkQm6eAGBeiE2KINOMW1
         DXx3CZyw0GV4X9TOexxDEbwmophZrlpluSOpLZYWzWfgrcBI2gfXzdSvFsmjeGhT35vx
         WhKPHgvAws4NjAlKDX4/Q3h6Nhuh+Sh97uP8ZWl+XUINk+pXMto4WAaJXax5+U1YEToT
         lcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0GMlhckD8lA0tBGGX9NXupfe37WIoUs0Ssud0Kl00eM=;
        b=kp1lUGzi5JI3+08b1CLWWVnBHNF6PKUfQ5LGkcai5TAsYFWfgkyFgyKBvrWRlGRiCR
         Nc2YcP70mJE4RGAICPNldD9ay3ZERW/rheqoIpqskTutEbAO0LjjCGEf0Kx9HaVaxhBy
         7+EnlEgaydc0P/rQ+pZacK1egzllPQ8BktYqlzp8B4Y966VwBFwrXiInY6tyWEweu5h/
         NO/uwWDgKkghFxVO/Lev0AKZWRMlQlPo8aCEGJw4xqstrHepby4lVhweTdRrBT12JCKZ
         eQYuyMovkOZiVdsP/LPxhs83HS0JYu4hj4CxkcgnB2m5XrI4w2FrmO0QNY82jrwzwesp
         wfBw==
X-Gm-Message-State: ACgBeo2M9CTOfELHL1v+NF/7wyXNgJ7eW6SXeeiKFC1pXBTR87QCy3KK
        5nBC+bGLgqg5vg0lwLU6QnIL/7SwS/T89tbZSxqtQA==
X-Google-Smtp-Source: AA6agR77aZ6p1BScwe9M8+QsapIQJesYyjWJDmlZeYHd/0FZ0FeTbbgFNEk+VDQauhly0xCLKP+aidwYPzA0bs59iMM=
X-Received: by 2002:a17:90b:4b42:b0:1fb:4e76:989a with SMTP id
 mi2-20020a17090b4b4200b001fb4e76989amr5050444pjb.120.1661291119003; Tue, 23
 Aug 2022 14:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220822194513.2655481-1-sdf@google.com> <20220822194513.2655481-3-sdf@google.com>
 <20220823162325.l2qezzntob27coym@kafai-mbp>
In-Reply-To: <20220823162325.l2qezzntob27coym@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 23 Aug 2022 14:45:06 -0700
Message-ID: <CAKH8qBvbXOF=YzoVAfqRDCNJnyQDMHs5xJuz5Fy08aoC=cQtTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/5] bpf: Use cgroup_{common,current}_func_proto
 in more hooks
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
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

On Tue, Aug 23, 2022 at 9:23 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Mon, Aug 22, 2022 at 12:45:10PM -0700, Stanislav Fomichev wrote:
> > +const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
> There is a 'ifdef CONFIG_CGROUP_NET_CLASSID' before using this proto.
> This should be not needed also.  Please check.
>
> However, a declaration is probably needed in include/linux/bpf.h.

Yeah, you're right, having one __weak somewhere + extern in the header
is enough. Will add extern for this one and remove these __weak
definitions (from both patches).

> >  const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
> > +const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto __weak;
> This one should be unnecessary also.
>
> Others lgtm.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thank you for the review!
