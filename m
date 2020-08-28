Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40271255F48
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgH1Q7h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgH1Q7g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 12:59:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2852DC061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 09:59:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w11so2085968ybi.23
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UCnfx+eh8tbpibVGujDP+/frQdya0UzuppsKtvHzp/0=;
        b=PhkCDP9Fs0SRL9irJUTK8tbaQFGLVP7PIr2x5vfPr3ZzcP8PrJ9aCXYs9cfsMQq/hm
         CW7leg+8P+/fCSwg1/deo91Qu7Mo6o8IS6TY9amgc+cqlgJa2PghnuxXu89lM4huEeK+
         qPCZijT3XgluGlBtSNZJ16IwAA+5yskTexaKvySENf37e+InDKI44H57haPvyiIHQ8dP
         L7AzY0vLtszDvpDJ6S+L1GM7cRAC871dWeJNPbrEbmwt4TVEpM+C/hCy6HMKjFAKyU95
         bMdgVIaDiHQDWqg3rQsc2xMDK+Nwep010wOPl2viLCaSFuqTrBxuo0RVCsxgq6PrQm3M
         faOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UCnfx+eh8tbpibVGujDP+/frQdya0UzuppsKtvHzp/0=;
        b=rjZFAykhtSPBbl2V5kMmtQValBf4+PRei1/A9Srl+jh7/++6P5YZh58+7ZYQNYLmsn
         Ykt5d5SoKl9B4lavm4jtACnuF0WPWVgJyyWWw4yoJQ7F+c5TkPdz/LA2HEuXMLyFhq5r
         B3g3+e8GaaZtmaK+Awt0XdY+LQ4wLVL0Iz2nBkbBiTZHjsAbABysKpM6w4AwwfmhOwEc
         ddTrLiGE8vUM7OYmZgwD2FyFqNTFmlBTeg+ZARvb2isaOlJZPMYNEZcEBRDvxmBa8YrW
         dmixOAF7uxhhgYE4qggvKK85DmngwCIcImTWDYSTiAoDlls6tVAbx+LGf7TYsaySIFFZ
         CzPg==
X-Gm-Message-State: AOAM532/98qqdPqrmk5HxadlkNW8plIr831sCYEf65bnr7AXwKN+RVDc
        GPHOJeYkujuMzVj2jt3kkiYAXaw=
X-Google-Smtp-Source: ABdhPJz6Sxl0Ofjmd0OBb3cmbX+ZYM2nQubSu47Q5R255ec1u7u+WqB8aKpPOcD7wmOAq2CXL91zOCI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:5555:: with SMTP id j82mr4032009ybb.125.1598633973572;
 Fri, 28 Aug 2020 09:59:33 -0700 (PDT)
Date:   Fri, 28 Aug 2020 09:59:31 -0700
In-Reply-To: <CAEf4BzaGFP=Ob5MOcQgBjFOdY8aP1gvNV68wTAzA-V3kR5BKYg@mail.gmail.com>
Message-Id: <20200828165931.GA48607@google.com>
Mime-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <CAEf4BzaGFP=Ob5MOcQgBjFOdY8aP1gvNV68wTAzA-V3kR5BKYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/25, Andrii Nakryiko wrote:
> On Thu, Aug 20, 2020 at 2:44 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> >
> > From: YiFei Zhu <zhuyifei@google.com>
> >
> > Added a flag "--metadata" to `bpftool prog list` to dump the metadata
> > contents. For some formatting some BTF code is put directly in the
> > metadata dumping. Sanity checks on the map and the kind of the btf_type
> > to make sure we are actually dumping what we are expecting.
> >
> > A helper jsonw_reset is added to json writer so we can reuse the same
> > json writer without having extraneous commas.
> >
> > Sample output:
> >
> >   $ bpftool prog --metadata
> >   6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
> >   [...]
> >         btf_id 4
> >         metadata:
> >                 metadata_a = "foo"
> >                 metadata_b = 1
> >
> >   $ bpftool prog --metadata --json --pretty
> >   [{
> >           "id": 6,
> >   [...]
> >           "btf_id": 4,
> >           "metadata": {
> >               "metadata_a": "foo",
> >               "metadata_b": 1
> >           }
> >       }
> >   ]
> >
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >  tools/bpf/bpftool/json_writer.c |   6 ++
> >  tools/bpf/bpftool/json_writer.h |   3 +
> >  tools/bpf/bpftool/main.c        |  10 +++
> >  tools/bpf/bpftool/main.h        |   1 +
> >  tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
> >  5 files changed, 155 insertions(+)
> >

> [...]

> > +       for (i = 0; i < prog_info.nr_map_ids; i++) {
> > +               map_fd = bpf_map_get_fd_by_id(map_ids[i]);
> > +               if (map_fd < 0)
> > +                       return;
> > +
> > +               err = bpf_obj_get_info_by_fd(map_fd, &map_info,  
> &map_info_len);
> > +               if (err)
> > +                       goto out_close;
> > +
> > +               if (map_info.type != BPF_MAP_TYPE_ARRAY)
> > +                       goto next_map;
> > +               if (map_info.key_size != sizeof(int))
> > +                       goto next_map;
> > +               if (map_info.max_entries != 1)
> > +                       goto next_map;
> > +               if (!map_info.btf_value_type_id)
> > +                       goto next_map;
> > +               if (!strstr(map_info.name, ".metadata"))

> This substring check sucks. Let's make libbpf call this map strictly
> ".metadata". Current convention of "some part of object name" + "." +
> {rodata,data,bss} is extremely confusing. In practice it's something
> incomprehensible and "unguessable" like "test_pr.rodata". I think it
> makes sense to call them just ".data", ".rodata", ".bss", and
> ".metadata". But that might break existing apps that do lookups based
> on map name (and might break skeleton as it is today, not sure). But
> let's at least start with ".metadata", as it's a new map and we can
> get it right from the start.
Isn't it bad from the consistency point of view? Even if it's bad,
at least it's consistent :-/
