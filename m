Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F2960FD91
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 18:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiJ0QzP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 12:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiJ0QzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 12:55:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416769BCD
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 09:55:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sc25so6350147ejc.12
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 09:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfJ45CNu/goqzxkpRWZ7PVFe6TMJSi1ylr/KZmg0YtM=;
        b=VO49aS3FXqH83MDI+2R97yiS3mOr5kKnVIsy+rg3cbWD7PFpUbx8gA6d5AhlalcfH0
         Sqv2V/qRHZuDn+cRasHrjBFlaPb8mrbBed06RWeWbF9hFLX2D9vYuFjB8SqYsjk36ubz
         sm8TNKZXnDvzzZxZWj+ir+lRu9hOKUphwbA1fF8vfv1bqrygWPg3rhhHmocCQPuh4so+
         jgSOGblIqOrPCkMRhG9tHvH6xy3bw4vQlE4UCpb0Li2/VoRWQ1oAtXBGmn5o4dFh5oTK
         nGaeuHpXF/TMNCdKMsLRfdbQOp5laXebDBq7i/lGQ2ZPeLWF4moZiOLRrsmXHsizrz+1
         rveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfJ45CNu/goqzxkpRWZ7PVFe6TMJSi1ylr/KZmg0YtM=;
        b=IAIBiHZjqBJW+WbN1fKKLsU1LaZDC/9mxde0y1B6j8ynVu2uFUQbjpxRvO1+bsjcsr
         CwaHXwwnLonHrwOVQCp6nJxVm4HJ5YJswoZzQOudkfDkxiSasEypcVu54EgVf0d+cUs5
         c7y8tisMh2GP0TrcpJB8TMzf9UZMdT0eEiovJxFZsDVteYzcebI/d+dNkoBSKHty81CY
         VnMbnPpvmP0MiavDHHbyRnq4E2mrcNh6DWzOjuhHjCW+rznyQLw5FqLXWPH91gvDQC2W
         uHcPp3CuiVzqXDTnmz5NnYmRoMSsSvjO96GrtBXMQMVFQVCuL9WU+7xcSLjd7N3YomAC
         BPfQ==
X-Gm-Message-State: ACrzQf0uOVwFDoCF5nKhrONNXlHf2sNr3MQRUC0hUbOsMqtAZ46v421+
        PkvcgqesCEc6Ow01v0sFzM8f4/uU4rbch26+kt4=
X-Google-Smtp-Source: AMsMyM5UR/+P91ewj0xKNuQa83J5zqOgb4XtQav+gmph3qrPxABsMjv4qG6v7z6Qivuk1XEXoTqo9Jermk1MgSWJ5GA=
X-Received: by 2002:a17:907:984:b0:77f:4d95:9e2f with SMTP id
 bf4-20020a170907098400b0077f4d959e2fmr44221037ejc.176.1666889709516; Thu, 27
 Oct 2022 09:55:09 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com> <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
In-Reply-To: <21be7356-8710-408a-94e3-1a0d3f5f842e@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 09:54:57 -0700
Message-ID: <CAEf4BzawXPiXY3mNabi0ggyTS9wtg6mh8x97=fYGhuGj4=2hnw@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 28, 2022 at 1:54 AM Lorenz Bauer <oss@lmb.io> wrote:
>
> On Thu, 15 Sep 2022, at 11:30, Lorenz Bauer wrote:
> > Hi list,
> >
> > Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF
> > map permission loophole", with slides at [0].
>
> I've put this topic on the agenda of the 2022-10-06 BPF office hours to get some maintainer attention. Details are here: https://docs.google.com/spreadsheets/d/1LfrDXZ9-fdhvPEp_LHkxAMYyxxpwBXjywWa0AejEveU/edit
>
> Best

So after the office hours I had an offline whiteboard discussion with
Alexei explaining more precisely what I was proposing, and it became
apparent that some of the things I was proposing weren't exactly
clear, and thus people were left confused about the solution I was
talking about. So I'll try to summarize it a bit and add some more
specifics. Hopefully that will help, because I still believe we can
solve this problem moving forward.

But first, two notes.

1) Backporting this is going to be hard, and I don't think that should
be the goal, it's going to be too intrusive, probably.

2) It turned out that we currently don't store user-space-side
read/write permissions on struct bpf_map itself, and we'd need to do
that as a preliminary step here. Below I just assume that struct
bpf_map records all the bpf-side and user-side read/write permissions.

So, the overall idea is that instead of fetching struct bpf_map point
for all kinds of FD-based operations (bpf_obj_get, map_fd_by_id, even
bpf_map_create) we are always working with a view of a map, and that
"view" is a separate struct/object, something like:

struct bpf_map_view {
    struct bpf_map *map;
    /* BPF_F_RDONLY | BPF_F_WRONLY, but we can later also add
       BPF-side flags: BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG
    */
    int access_flags;
}

So whenever we work with map by FD, we get struct bpf_map_view (i.e.,
we store struct bpf_map_view inside file->private and
inode->i_private). The semantics of view->access_flags is that it is
superimposed on top of bpf_map->map_flags (specifically its
BPF_F_RDONLY | BPF_F_WRONLY parts, later also BPF_F_RDONLY_PROG |
BPF_F_WRONLY_PROG). This means that if struct bpf_map is R/W, but our
current bpf_map_view says BPF_F_RDONLY, then only read-only access is
allowed through that FD. On the other hand, if bpf_map itself is only
BPF_F_RDONLY, but we somehow go bpf_map_view with BPF_F_RDONLY |
BPF_F_WRONLY (e.g., due to chmod loophole), then it doesn't matter,
it's still BPF_F_RDONLY, no write access. We can try preventing such
situations in some circumstances, but as we showed with chmod() it's
impossible to prevent in general.

So, just to hopefully make it a bit clearer, let's discuss a use case
that a bunch of people had in mind. Root/CAP_BPF user created R/W
bpf_map, but wants to pin it in one BPFFS path as R/W, so that it can
be later opened as R/W and modified. This BPFFS path will be
restricted through FS permissions to only allow it to be opened by a
privileged user/group. But, that same original root/CAP_BPF user would
like to also create a read-only BPFFS pinning of that same map, and
let unprivileged user(s) to open and work with that map, but only
perform read-only operations (e.g., BPF_MAP_LOOKUP_ELEM command).

Let's see how that works in this new bpf_map_view model.

1. root/CAP_BPF user does BPF_MAP_CREATE operation, struct bpf_map is
created with map_flags BPF_F_RDONLY | BPF_F_WRONLY. Also, immediately
struct bpf_map_view is created with same BPF_F_RDONLY | BPF_F_WRONLY
access_flags. struct bpf_map_view keeps reference on struct bpf_map,
struct bpf_map_view is assigned to struct file->private, new FD is
returned to user-space.

2. That same root/CAP_BPF user does BPF_OBJ_PIN and specifies that
they want R/W pinning (through file_flags). Kernel clones/copies
struct bpf_map_view (I think bpf_map_view shouldn't be shared between
files/inodes, each file/inode has its own personal copy; but we can
work out the details later), sets (keeps in this case) its
access_flags as  BPF_F_RDONLY | BPF_F_WRONLY. After that they are free
to chown/chmod as necessary to prevent unprivileged user from doing
anything with that BPFFS file, if necessary.

3. Now, for the read-only pinning. User does another BPF_OBJ_PIN using
original R/W map FD, but now they specify file_flags to only allow
BPF_F_RDONLY (I'm too lazy to check what exact flag we pass there to
communicate this intent, it's not that important for this discussion).
At this point, kernel creates a new struct bpf_map_view, pointing to
struct bpf_map, but this time access_flags have only BPF_F_RDONLY set.
Then we proceed to creating an inode, its i_private is assigned this
new R/O bpf_map_view. The user should chmod/chown pinned BPFFS file
appropriately to allow unprivileged users to BPF_OBJ_GET it.


Now, let's assume we are unprivileged user who wants to work with that
pinned BPF map. When we do BPF_OBJ_GET on that read-only pinned file,
kernel fetches struct bpf_map_view from inode->i_private which has
access_flags as BPF_F_RDONLY. That's it, there is no way we can do
update on that map, kernel will reject that even though struct bpf_map
itself allows BPF_F_WRONLY.

Note, though, that once we checked everything, as we create a new
struct file and return new FD to user-space, that new struct file will
have *yet another copy* of struct bpf_map_view, cloned from inode's
bpf_map_view (recall that I was proposing to have 1-to-1 mapping
between file/inode and bpf_map_view).


Let's now assume we are sneaky bastards and chmod that second pinned
BPFFS file to allow r/w file permissions. When we do BPF_OBJ_GET,
again, we'll fetch struct bpf_map_view which enforce BPF_F_RDONLY
(only), despite file itself having writable permissions. We can argue
if we should reject such BPF_OBJ_GET command or silently "downgrade"
to read-only view, that's beside the point.

Hopefully this is a bit clearer.

One last note. When we are talking about BPF_OBJ_GET, we are actually
going to be dealing with 4 layers of read and write permissions:
  1) struct bpf_map's "inherent" permissions
  2) struct bpf_map_view's access_flags
  3) struct file's FS read/write permissions
  4) union bpf_attr's file_flags specified for BPF_OBJ_GET

While that's a lot, we always intersect them and keep only the most
restrictive combination. So if at any of the layers we have read-only
permissions, resulting *new struct bpf_map_view* will only specify
BPF_F_RDONLY. E.g., if at layers 1, 2, and 4 we allow BPF_F_WRONLY,
but BPFFS file permission (layer #3 above) at that moment is
read-only, we should be only getting read-only view of BPF map.

P.S. We can extend this to BPF-side BPF_F_RDONLY_PROG |
BPF_F_WRONLY_PROG as well, it's just that we'll need to define how
user will control that. E.g., FS read-only permission, does it
restrict both user-space and BPF-view, or just user-space view? We can
certainly extend file_flags to allow users to get BPF-side read-only
and user-space-side read-write BPF map FD, for example. Obviously, BPF
verifier would need to know about struct bpf_map_view when accepting
BPF map FD in ldimm64 and such.

Alright, that's what I think I had to say. Please point out scenarios
that won't be covered by this bpf_map_view model. Thanks.
