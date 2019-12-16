Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD512094B
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2019 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLPPHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Dec 2019 10:07:25 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:46450 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfLPPHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Dec 2019 10:07:25 -0500
Received: by mail-pj1-f47.google.com with SMTP id z21so3090055pjq.13;
        Mon, 16 Dec 2019 07:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w1x7CdwPpFB9tMt33QAUdGJiRC4Yu2yWQ6k7waNcRdI=;
        b=FeVz2eROru6DQX/nbODTLrCvI1/LYkFVgb8VIUbu7KTae83OLIUal1rn4pvEwTP25Y
         uCX154JAX3OHR8eHE51N1x3/9REPoMXQFApqciyk8UO9H4dCpcnWzoQG5VWGpyqoSDlz
         hMLG1OcpH41lVNiInelo9veSWUrtMlPypgtYSp2DHlsQmphEZgr/hYtus6QdfgNJUnBm
         PnOxAbJbMmftPNP5wcGF+ivkNxcKqXPYVETiZt2tNnOgH8Zu0NAgfyiaRFfOg/hSg6JA
         bafjaZ63W2AnEKZW+007GQwp/WhU+xrgJKimKTJreTOglA1FhIJvVPid1f4Zv5++JWhB
         KTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w1x7CdwPpFB9tMt33QAUdGJiRC4Yu2yWQ6k7waNcRdI=;
        b=ui7ARdiNtywYKqnaPB9YEloA61HKhkZg4+IU7gsc7cfHNiWe79ryufnE4F4NaDve/J
         Gg1GTUo4uZ2Rq9h14bbuIRWYAHz5OKsS6Rkd+OJj/+3raDvnuNamVLMqAgoh9ZN7QXen
         XqWMd7S4CoyBuzKT7pKhv0nVYa60nkUDtoPjREzZhIRYnYoArma103TC5FflwXgW65jv
         kG/8QoLVhxgJ2zFLGav3SQMqFsU+XmsQJNlvUByRBrZHFID5/evE2s5v8DGpql9mayPl
         Z7wNbvTXTlNP4B1Us3EQDj4hu5otRxpZZBt22O0nEGrbD0+afRWatBQkPZZhptMgBy+L
         Bs8w==
X-Gm-Message-State: APjAAAUPZic5DgSlJGrYuOeLRAotT2wUch554ndBvxEJcDrZ27dyKQTr
        RxrMqFBeIwa2NI43RRtk1XE=
X-Google-Smtp-Source: APXvYqyy7fW1pFDv6HA8QWJwGAqSosA/SFusVWFRFXnkLTe2VKpi9vY/N/A1eTLAhPAc4RUz2JaU6A==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr16117764plv.331.1576508844251;
        Mon, 16 Dec 2019 07:07:24 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id e6sm23024144pfh.32.2019.12.16.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 07:07:23 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 661EA40352; Mon, 16 Dec 2019 12:07:20 -0300 (-03)
Date:   Mon, 16 Dec 2019 12:07:20 -0300
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        David Seifert <soap@gentoo.org>,
        Pavel Borzenkov <pavel.borzenkov@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Gareth Lloyd <gareth.lloyd@uk.ibm.com>,
        Martin Cermak <mcermak@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: ANNOUNCE: pahole v1.16 (Fixes + BTF_KIND_FUNC)
Message-ID: <20191216150720.GA18669@kernel.org>
References: <20190626211613.GE3902@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626211613.GE3902@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

	The v1.16 release of pahole and its friends is out, available at
the usual places:

Main git repo:

   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:

   https://github.com/acmel/dwarves.git

tarball + gpg signature:

   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.16.tar.sign

Best Regards,

- Arnaldo

v1.16 changes:

BTF encoder:

  Andrii Nakryiko <andriin@fb.com>:

  - Preserve and encode exported functions as BTF_KIND_FUNC.

    Add encoding of DWARF's DW_TAG_subprogram_type into BTF's BTF_KIND_FUNC
    (plus corresponding BTF_KIND_FUNC_PROTO). Only exported functions are converted
    for now. This allows to capture all the exported kernel functions, same subset
    that's exposed through /proc/kallsyms.

BTF loader:

  Arnaldo Carvalho de Melo <acme@redhat.com>

  - Add support for BTF_KIND_FUNC

    Some changes to the fprintf routines were needed, as BTF has as the
    function type just a BTF_KIND_FUNC_PROTO, while DWARF has as the type for a
    function its return value type. With a function->btf flag this was overcome and
    all the other goodies in pfunct are present.

Pretty printer:

  Arnaldo Carvalho de Melo:

  - Account inline type __aligned__ member types for spacing:

              union {
                      refcount_t         rcu_users;            /*  2568     4 */
                      struct callback_head rcu __attribute__((__aligned__(8))); /*  2568    16 */
      -       } __attribute__((__aligned__(8)));                                               /*  2568    16 */
      +       } __attribute__((__aligned__(8)));               /*  2568    16 */
              struct pipe_inode_info *   splice_pipe;          /*  2584     8 */

  - Fix alignment of class members that are structs/enums/unions

    E.g. look at that 'completion' member in this struct:

       struct cpu_stop_done {
              atomic_t                   nr_todo;              /*     0     4 */
              int                        ret;                  /*     4     4 */
      -       struct completion  completion;                   /*     8    32 */
      +       struct completion          completion;           /*     8    32 */

              /* size: 40, cachelines: 1, members: 3 */
              /* last cacheline: 40 bytes */

  - Fixup handling classes with no members, solving a NULL deref.

  Gareth Lloyd <gareth.lloyd@uk.ibm.com>:

  - Avoid infinite loop trying to determine type with static data member of its own type.

RPM spec file.

Jiri Olsa <jolsa@redhat.com>

    Add dwarves dependency on libdwarves1.

pfunct:

  Arnaldo Carvalho de Melo <acme@redhat.com>

  - type->type == 0 is void, fix --compile for that

    We were using the fall back for that, i.e. 'return 0;' was being emitted
    for a function returning void, noticed with using BTF as the format.

pdwtags:

    - Print DW_TAG_subroutine_type as well

      So that we can see at least via pdwtags those tags, be it from DWARF of BTF.

core:

  Arnaldo Carvalho de Melo <acme@redhat.com>

    Fix ptr_table__add_with_id() handling of pt->nr_entries, covering how
    BTF variables IDs are encoded.


pglobal:

  Arnaldo Carvalho de Melo <acme@redhat.com>:

  - Allow passing the format path specifier, to use with BTF

    I.e. now we can, just like with pahole, use:

      pglobal -F btf --variable foo.o

    To get the global variables.

Tree wide:

  Arnaldo Carvalho de Melo <acme@redhat.com>:

  - Fixup issues pointed out by various coverity reports.
