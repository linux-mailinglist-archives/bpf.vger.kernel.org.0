Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF0B4AC88E
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 19:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiBGSbe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 13:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiBGS0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 13:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D87ADC0401D9
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644258395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8frE26fsDjG0Wt6AT8xDPgAVJFo8aA64oEGzjmK67mE=;
        b=HPMNVM/qJlCoYWlg/ogZRN80WXBz8Rp7lVPRJ+7S45STYvq4c9+cT1YyBA2pTa3nb+FtER
        S82++WrDDc5eZhPL5OszvqarLpN5PksC//KEfyFy1BG87CWOL9CxJgFt6NGF9yQr5nTAgM
        RLpF2O8/r0QVV+U5XoWYUN8uvlMa/vs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-BrDh6k0DMJKYA0cPDO1qGg-1; Mon, 07 Feb 2022 13:26:33 -0500
X-MC-Unique: BrDh6k0DMJKYA0cPDO1qGg-1
Received: by mail-ej1-f69.google.com with SMTP id z26-20020a1709067e5a00b006cbe0628826so985641ejr.10
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 10:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8frE26fsDjG0Wt6AT8xDPgAVJFo8aA64oEGzjmK67mE=;
        b=1bvTESmrCEJmD7Jr5Yhnxyzfm3/AS8+5NjiX0TUZmBsf5yBC0gVq5zqN9U5zbUWObO
         Nb0cRyWi7xM/AMQ3N/mN0kT4I6gbj/o0FhY5FINo4eXyiBocIGzNjtzrgpH9n8MW27t0
         NEX0XicatcogUCeRTeNe3VmmLtWRrvinRPP4Be2x3OOzCYo4oN1IOlGzgTaJWrKxhxGn
         xorNc8OjKMyyc+9BrivC0z2K9m7qP/6aGcddEJuCgyJR0QDfcGVvD0D8XoNHEs3jL9HU
         gL+tCnkNQVVQVnATmPhSs+Hm14Wbaze90+0Kfr7VvnMT1YJ7uZ5tJGgoOMqrmPBIfRax
         8X4Q==
X-Gm-Message-State: AOAM531b/zJk/ivPsRQyW9zIJ7F9KjRojq7v1l80QFtvxre/GlAFyygP
        b1eeyS6CpF+JmleULqSz9HcYuYUq2SvMx+UFRbt4CBlp77jvCOKAlCfoTUejqdrTbWY69CW4DF+
        nuj6WBwkAnJj5
X-Received: by 2002:a05:6402:1910:: with SMTP id e16mr763625edz.11.1644258392046;
        Mon, 07 Feb 2022 10:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9vPOMXCazRuIkRJzSTxpwkvx61vkLwYpZ0vocfzGkkDbBBBFbidhx5M2+GF/IibPb0ke6Xg==
X-Received: by 2002:a05:6402:1910:: with SMTP id e16mr763610edz.11.1644258391865;
        Mon, 07 Feb 2022 10:26:31 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id n14sm306571eja.219.2022.02.07.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:26:31 -0800 (PST)
Date:   Mon, 7 Feb 2022 19:26:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yinjun Zhang <yinjun.zhang@corigine.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, niklas.soderlund@corigine.com,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Message-ID: <YgFkVXggmihEpO/o@krava>
References: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
 <CAEf4BzbjVnkb8Oz67p3jDhL-Pv9RG-wq1A7KMV06zowRK9psew@mail.gmail.com>
 <YgFdgOVdEWUx63Ik@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgFdgOVdEWUx63Ik@krava>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 07, 2022 at 06:57:20PM +0100, Jiri Olsa wrote:
> On Mon, Feb 07, 2022 at 09:42:25AM -0800, Andrii Nakryiko wrote:
> > On Mon, Feb 7, 2022 at 8:00 AM Yinjun Zhang <yinjun.zhang@corigine.com> wrote:
> > >
> > > When reworking btf__get_from_id() in commit a19f93cfafdf the error
> > > handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
> > > if bpf_btf_get_fd_by_id() failed the error would not be propagated to
> > > callers of btf__get_from_id(), after the rework it is. This lead to a
> > > change in behavior in print_key_value() that now prints an error when
> > > trying to lookup keys in maps with no btf available.
> > >
> > > Fix this by following the way used in dumping maps to allow to look up
> > > keys in no-btf maps, by which it decides whether and where to get the
> > > btf info according to the btf value type.
> > >
> > > Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
> > > Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
> > > Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> > > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > > ---
> > >  tools/bpf/bpftool/map.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> > > index cc530a229812..4fc772d66e3a 100644
> > > --- a/tools/bpf/bpftool/map.c
> > > +++ b/tools/bpf/bpftool/map.c
> > > @@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
> > >         json_writer_t *btf_wtr;
> > >         struct btf *btf;
> > >
> > > -       btf = btf__load_from_kernel_by_id(info->btf_id);
> > > -       if (libbpf_get_error(btf)) {
> > > -               p_err("failed to get btf");
> > > +       btf = get_map_kv_btf(info);
> > > +       if (libbpf_get_error(btf))
> > 
> > See discussion in [0], it seems relevant.
> > 
> >   [0] https://lore.kernel.org/bpf/20220204225823.339548-3-jolsa@kernel.org/
> 
> I checked and this patch does not fix the problem for me,
> but looks like similar issue, do you have test case for this?
> 
> mine is to dump any no-btf map with -p option

anyway I think your change should go in separately,
I can send change below (v2 for [0] above) on top of yours

thanks,
jirka


---
 tools/bpf/bpftool/map.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c66a3c979b7a..8562add7417d 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -805,29 +805,28 @@ static int maps_have_btf(int *fds, int nb_fds)
 
 static struct btf *btf_vmlinux;
 
-static struct btf *get_map_kv_btf(const struct bpf_map_info *info)
+static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
 {
-	struct btf *btf = NULL;
+	int err = 0;
 
 	if (info->btf_vmlinux_value_type_id) {
 		if (!btf_vmlinux) {
 			btf_vmlinux = libbpf_find_kernel_btf();
-			if (libbpf_get_error(btf_vmlinux))
+			err = libbpf_get_error(btf_vmlinux);
+			if (err) {
 				p_err("failed to get kernel btf");
+				return err;
+			}
 		}
-		return btf_vmlinux;
+		*btf = btf_vmlinux;
 	} else if (info->btf_value_type_id) {
-		int err;
-
-		btf = btf__load_from_kernel_by_id(info->btf_id);
-		err = libbpf_get_error(btf);
-		if (err) {
+		*btf = btf__load_from_kernel_by_id(info->btf_id);
+		err = libbpf_get_error(*btf);
+		if (err)
 			p_err("failed to get btf");
-			btf = ERR_PTR(err);
-		}
 	}
 
-	return btf;
+	return err;
 }
 
 static void free_map_kv_btf(struct btf *btf)
@@ -862,8 +861,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	prev_key = NULL;
 
 	if (wtr) {
-		btf = get_map_kv_btf(info);
-		err = libbpf_get_error(btf);
+		err = get_map_kv_btf(info, &btf);
 		if (err) {
 			goto exit_free;
 		}
@@ -1054,11 +1052,8 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	json_writer_t *btf_wtr;
 	struct btf *btf;
 
-	btf = btf__load_from_kernel_by_id(info->btf_id);
-	if (libbpf_get_error(btf)) {
-		p_err("failed to get btf");
+	if (get_map_kv_btf(info, &btf))
 		return;
-	}
 
 	if (json_output) {
 		print_entry_json(info, key, value, btf);
-- 
2.34.1

