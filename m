Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7B6B6DD6
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 04:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCMDJ5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 23:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCMDJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 23:09:44 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12CE3B5;
        Sun, 12 Mar 2023 20:09:42 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id y3so7445226qvn.4;
        Sun, 12 Mar 2023 20:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678676981;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeCN+vGycPjjiXBhDFbMeoBozzcJZj5zCfhIwuUjQhI=;
        b=Xd3uq3Hjj1b9OI8uJJyiWjuSMKpxAyXrPUUWMpwMVc94hsVaOOG6cbwKzX7oOyd6DJ
         0X1phmKksmIB/Bo+T79G5LRBVRarvckBQsGWPLd4M6t5JOuUq/PtKjfeQazWVPED9xBV
         hLZgiZGSqrpdvxCKd6acuWd1bVen8CqJxXxhDrgdqeQlgdH4d3CpRMo/KkheymXnkAu8
         6SLfxz1bmXqk64tc3zVlqHeM7HJBKv23KLOtH1rloB0g/6HBGh7+pqjpKkcZVjveJzgB
         kO+bOWOBcdRs3JhogTarqazc5PjotfDJEQXnUaJq4+iczeZskif2nJO2nzNyKAfgrggR
         k33w==
X-Gm-Message-State: AO0yUKXuopAY5H8QYSmvMTUo6T92LlKemopF1AI9fPfDUXB0tUFMqgwn
        mriu7qKF/ZHoT0ZVsuJIfdY=
X-Google-Smtp-Source: AK7set9wsQ9bQ+JAqGmb/so+XDS0N2/uDMVI8T4aFvpoZye1cUH71dNog5QN1KTcuY/RRctUDDtEww==
X-Received: by 2002:ad4:574a:0:b0:56e:b16d:ec93 with SMTP id q10-20020ad4574a000000b0056eb16dec93mr12626237qvx.4.1678676981447;
        Sun, 12 Mar 2023 20:09:41 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:bf74])
        by smtp.gmail.com with ESMTPSA id a195-20020ae9e8cc000000b007425dade624sm4605515qkg.41.2023.03.12.20.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 20:09:40 -0700 (PDT)
Date:   Sun, 12 Mar 2023 22:09:38 -0500
From:   David Vernet <void@manifault.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
Message-ID: <20230313030938.GA152792@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313025119.17430-1-bagasdotme@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 09:51:19AM +0700, Bagas Sanjaya wrote:
> Commit d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target") fixes
> link to netdev FAQ documentation introduced in <blurb> introduced in
> 287f4fa99a5281 ("docs: Update references to netdev-FAQ"), although the
> former commit doesn't mention Fixes: to the latter. However, the former
> changes the link to external link to docs.kernel.org, in contrast to the
> internal linking employed by the latter.
> 
> Use :doc: directive for linking to netdev FAQ doc, while keeping the
> anchor text intact and consistency with intention of 287f4fa99a5281.
> 
> Fixes: d56b0c461d19da ("bpf, docs: Fix link to netdev-FAQ target")
> Fixes: 287f4fa99a5281 ("docs: Update references to netdev-FAQ")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

This regresses all of the warnings I fixed in d56b0c461d19da ("bpf,
docs: Fix link to netdev-FAQ target"):

[void@maniforge bpf-next]$ make -j SPHINXDIRS="bpf" htmldocs
make[2]: Nothing to be done for 'html'.
Using alabaster theme
source directory: bpf
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:125: WARNING: unknown document: '/process/maintainer-netdev'
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:150: WARNING: unknown document: '/process/maintainer-netdev'
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:207: WARNING: unknown document: '/process/maintainer-netdev'
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:232: WARNING: unknown document: '/process/maintainer-netdev'
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:398: WARNING: unknown document: '/process/maintainer-netdev'
/home/void/upstream/bpf-next/Documentation/bpf/bpf_devel_QA.rst:414: WARNING: unknown document: '/process/maintainer-netdev'

And it also causes the netdev-FAQ links to once again be broken and not
actually point to anything.

> ---
>  Indeed, this internal linking fix should have been made against bpf
>  tree, since the problematic original linking in 287f4fa99a5281 is also
>  seen in bpf tree. If that is the case, I will rebase on that tree.
> 
>  Documentation/bpf/bpf_devel_QA.rst | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 5f5f9ccc3862b4..e523991da9e0ce 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -128,7 +128,7 @@ into the bpf-next tree will make their way into net-next tree. net and
>  net-next are both run by David S. Miller. From there, they will go
>  into the kernel mainline tree run by Linus Torvalds. To read up on the
>  process of net and net-next being merged into the mainline tree, see
> -the `netdev-FAQ`_.
> +the :doc:`netdev-FAQ </process/maintainer-netdev>`.
>  
>  
>  
> @@ -147,7 +147,8 @@ request)::
>  Q: How do I indicate which tree (bpf vs. bpf-next) my patch should be applied to?
>  ---------------------------------------------------------------------------------
>  
> -A: The process is the very same as described in the `netdev-FAQ`_,
> +A: The process is the very same as described in the
> +:doc:`netdev-FAQ </process/maintainer-netdev>`,
>  so please read up on it. The subject line must indicate whether the
>  patch is a fix or rather "next-like" content in order to let the
>  maintainers know whether it is targeted at bpf or bpf-next.
> @@ -206,8 +207,8 @@ ii) run extensive BPF test suite and
>  Once the BPF pull request was accepted by David S. Miller, then
>  the patches end up in net or net-next tree, respectively, and
>  make their way from there further into mainline. Again, see the
> -`netdev-FAQ`_ for additional information e.g. on how often they are
> -merged to mainline.
> +:doc:`netdev-FAQ </process/maintainer-netdev>` for additional
> +information e.g. on how often they are merged to mainline.
>  
>  Q: How long do I need to wait for feedback on my BPF patches?
>  -------------------------------------------------------------
> @@ -230,7 +231,8 @@ Q: Are patches applied to bpf-next when the merge window is open?
>  -----------------------------------------------------------------
>  A: For the time when the merge window is open, bpf-next will not be
>  processed. This is roughly analogous to net-next patch processing,
> -so feel free to read up on the `netdev-FAQ`_ about further details.
> +so feel free to read up on the
> +:doc:`netdev-FAQ </process/maintainer-netdev>` about further details.
>  
>  During those two weeks of merge window, we might ask you to resend
>  your patch series once bpf-next is open again. Once Linus released
> @@ -394,7 +396,7 @@ netdev kernel mailing list in Cc and ask for the fix to be queued up:
>    netdev@vger.kernel.org
>  
>  The process in general is the same as on netdev itself, see also the
> -`netdev-FAQ`_.
> +:doc:`netdev-FAQ </process/maintainer-netdev>`.
>  
>  Q: Do you also backport to kernels not currently maintained as stable?
>  ----------------------------------------------------------------------
> @@ -410,7 +412,7 @@ Q: The BPF patch I am about to submit needs to go to stable as well
>  What should I do?
>  
>  A: The same rules apply as with netdev patch submissions in general, see
> -the `netdev-FAQ`_.
> +the :doc:`netdev-FAQ </process/maintainer-netdev>`.
>  
>  Never add "``Cc: stable@vger.kernel.org``" to the patch description, but
>  ask the BPF maintainers to queue the patches instead. This can be done
> @@ -685,7 +687,6 @@ when:
>  
>  .. Links
>  .. _Documentation/process/: https://www.kernel.org/doc/html/latest/process/
> -.. _netdev-FAQ: https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>  .. _selftests:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
>  .. _Documentation/dev-tools/kselftest.rst:
> 
> base-commit: 49b5300f1f8f2b542b31d63043c2febd13edbe3a
> -- 
> An old man doll... just what I always wanted! - Clara
> 
