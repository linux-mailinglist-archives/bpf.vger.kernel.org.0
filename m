Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52304CC6C6
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiCCUFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 15:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiCCUFf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 15:05:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA4B1A614A;
        Thu,  3 Mar 2022 12:04:49 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so8768072pjb.3;
        Thu, 03 Mar 2022 12:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yho2Dl6zShl3TZZkq1NcbPCns9z7cGft4LPJ8Xl368w=;
        b=lNS2rMT/gK/+w8QkIK7rO4Qt3B+qUPqMdfDWn/FJac6BVBaQdMJwxQdT4MuC2HqW8t
         b/1J0jdLkcBwL//tj0M7RSAfqLlsr8ED+x3NFybe82/2VMTuCfNht74yMgRG59m0DP2e
         JYWEt/VknEWSkSn61Z5C76z3wpiHlfBma9KkjsqULcNNRJVFB3Gqvv8gzXl43+0+a0+v
         KMq749VxNgBmbF3u9egK/k4U0wxBUF+nQorgurHA98GZbQmyJaQG3MF0DcYHpOVrjR3T
         Uev8EZ0dHD8uxoILnNPsifEMA7D2eP1E4FtH4HaKzrl2S+ORlO/OF79ZIZjfM7OBUCWI
         noBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yho2Dl6zShl3TZZkq1NcbPCns9z7cGft4LPJ8Xl368w=;
        b=eFGupIYmIb1CAdIRIHgZVBFC0cjA2Na/LakH+pQ39/cOSItwUHnfCgadb1vKBRywnt
         DOXhqYFhDoNLeWfhml7VK0TZ0ye7TdLhegIiU6wK/4/CM9nRz24yBstvflmbRid7bGHS
         XaM1Ctg37Bfw4tFU6euWAwTxEvnIWvIMK/B7s9X5iRoDWh5Q8TRhFpQWGvY5lQ3Wq268
         PCA3srMZVRGRRmeJwy1l4synCIXpAArULQcW+FD0x3zMrDqoB4fSzxl4rCXkt+Ttbeo9
         3eS31/umvBqu5C1Zp5TjXNBuwBmt5Or1SRMIeEkEdRjGmkKZPDi1KloPGvDt5K1X2p2M
         PZ7w==
X-Gm-Message-State: AOAM5331utJuhK2iGJGcthX+RemEvGZLw8/BX28LzHPqrhp/VG6EGXoN
        QLzLUUDP6QJALRj/ZFEfLkk1qWo3fI8tt8owRME=
X-Google-Smtp-Source: ABdhPJwznKq7WAlWGc5jU9fVVPRFGTBBbRz1nOWEus/QP1k4cwGVZuGTO18YEyGhePknq75Rx4utv2aqTmUl0FhyLwk=
X-Received: by 2002:a17:902:e807:b0:150:2801:86f8 with SMTP id
 u7-20020a170902e80700b00150280186f8mr32835951plg.64.1646337889035; Thu, 03
 Mar 2022 12:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-5-haoluo@google.com>
 <c323bce9-a04e-b1c3-580a-783fde259d60@fb.com> <CAADnVQ+q0vF03cH8w0c50XMZU1yf_0UjZ+ZarQ_RqMQrVpOFPA@mail.gmail.com>
 <93c3fc30-ad38-96fa-cf8e-20e55b267a3b@fb.com> <CAADnVQL4yxhDCLjvCCmpOtg0+8-HSg32KG07TCxx+L+Gji7n6g@mail.gmail.com>
 <CA+khW7gyOGgqJjyuSjJMJ8+iQmozZ6VhSJ7exZF0gGLOeS5gog@mail.gmail.com> <CAADnVQ+wsp1+4DvrJjw_CAZDatsaQKKz-ZZADdTqSfUAqhv3SA@mail.gmail.com>
In-Reply-To: <CAADnVQ+wsp1+4DvrJjw_CAZDatsaQKKz-ZZADdTqSfUAqhv3SA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Mar 2022 12:04:37 -0800
Message-ID: <CAADnVQ+YBiHR5NyAww3_Y7sW2iANPcVB42SEqdxrvXmaVSEgjg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/9] bpf: Introduce sleepable tracepoints
To:     Hao Luo <haoluo@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 12:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 3, 2022 at 11:43 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Wed, Mar 2, 2022 at 6:29 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Mar 2, 2022 at 5:09 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 3/2/22 1:30 PM, Alexei Starovoitov wrote:
> > > > > On Wed, Mar 2, 2022 at 1:23 PM Yonghong Song <yhs@fb.com> wrote:
> > > > >>
> > > > >>
> > > > >>
> > > > >> On 2/25/22 3:43 PM, Hao Luo wrote:
> > > > >>> Add a new type of bpf tracepoints: sleepable tracepoints, which allows
> > > > >>> the handler to make calls that may sleep. With sleepable tracepoints, a
> > > > >>> set of syscall helpers (which may sleep) may also be called from
> > > > >>> sleepable tracepoints.
> > > > >>
> > > > >> There are some old discussions on sleepable tracepoints, maybe
> > > > >> worthwhile to take a look.
> > > > >>
> > > > >> https://lore.kernel.org/bpf/20210218222125.46565-5-mjeanson@efficios.com/T/
> > > > >
> > > > > Right. It's very much related, but obsolete too.
> > > > > We don't need any of that for sleeptable _raw_ tps.
> > > > > I prefer to stay with "sleepable" name as well to
> > > > > match the rest of the bpf sleepable code.
> > > > > In all cases it's faultable.
> > > >
> > > > sounds good to me. Agree that for the bpf user case, Hao's
> > > > implementation should be enough.
> > >
> > > Just remembered that we can also do trivial noinline __weak
> > > nop function and mark it sleepable on the verifier side.
> > > That's what we were planning to do to trace map update/delete ops
> > > in Joe Burton's series.
> > > Then we don't need to extend tp infra.
> > > I'm fine whichever way. I see pros and cons in both options.
> >
> > Joe is also cc'ed in this patchset, I will sync up with him on the
> > status of trace map work.
> >
> > Alexei, do we have potentially other variants of tp? We can make the
> > current u16 sleepable a flag, so we can reuse this flag later when we
> > have another type of tracepoints.
>
> When we added the ability to attach to kernel functions and mark them
> as allow_error_inject the usefulness of tracepoints and even
> writeable tracepoints was deminissed.
> If we do sleepable tracepoint, I suspect, it may be the last extension
> in that area.
> I guess I'm convincing myself that noinline weak nop func
> is better here. Just like it's better for Joe's map tracing.

To add to the above... The only downside of sleepable nop func
comparing to tp is the lack of static_branch.
So this nop call will always be there.
For map tracing and for cgroup mkdir/rmdir the few nanosecond
overhead of calling an empty function isn't even measurable.
