Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936D03115DE
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhBEWoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhBENnX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 08:43:23 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827BC06121C
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 05:42:41 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id v130so5800020qkb.14
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 05:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Jm9Rl/O23yAE3HZ62rmeV5YrYLNhsE5EvtDbKOWTIow=;
        b=ITUIwpQ8q9tGG4CIbJ0ci2ur/ZJSsEfgdPWAsLObON4aNaUKWMRH5VuROapZFGrYus
         5fa4bI8iLDZEm6l3nYLFzlHxdrDFx1EUQaNjXPKHot4OYnaoGLNYA1h6JiSpo7jIlsRk
         9kGukaEg//ID1Nn1O0irdtWgsIy+PqYgGTCvcp4DYU/jZ0z6ALvjbt6mBliklwtDJrP9
         2bdtZhULisqdwWNw2HrnTW6zNKNpRYi/LKfkYQ2eH5/6iRYGGXS+nw4oYVROKHHzq8+u
         GBJ+Wo6dJDdLsur/AV9T2DNq+iNqolHUVKv3hNLa9huQZxg88b2FUgzoTsihgXyKgR04
         HXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jm9Rl/O23yAE3HZ62rmeV5YrYLNhsE5EvtDbKOWTIow=;
        b=P7vpKllDSqca/i3nOjYEHh0jTDjCyMkT1bkb9OcLijpE4nUbEDgv1UUdEol26+Ehra
         Wlr0ZO8lbxOewSwprUYtHO9fBvXUVybxHATUycNxdUHxs4e5gx6RQN3xtfZQ1jxhHikS
         8c04al6v7gZDwCQzTtAx7a9TtDdrQybGiK8y/tPvfX8TbWDisx2phR644SSzSz0PpzGS
         lDhn4SBeTb4LCxRCcxhffhjrH3/FbckfcC5CFru9OdG9XZuqWVJ74937B2EBy67ZAwkT
         hA1K7Vy/lFVIWRpaCS1OXKgN1yTXBlvTcmEMb+F1lN0QHb+pvJvd2szMwgxTii3Dw7SL
         o7Ng==
X-Gm-Message-State: AOAM531MQ03pqDg5S5nZgFqNXR3Edo4pTzlEGh2uxiRRzPX9n8R7JO+C
        E8dBSzHRyB7/P+CCtvmhOgrEUxj9gpANHQ==
X-Google-Smtp-Source: ABdhPJzIz42Mwp/Z6N9/StY2UCNjQr9VPyc9b4cxNS9Y9mkf9ti9vhjfcwqC/1Op+ISWE/P5kp6cce7rWt8WIw==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a05:6214:906:: with SMTP id
 dj6mr4375856qvb.28.1612532560829; Fri, 05 Feb 2021 05:42:40 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:18 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Many operations in the libelf API return a pointer to a user-provided
struct (on success) or NULL (on failure).

There are a couple of places in btf_elf__write where both structs and
pointers to the same structs are used. Holding on to the pointers
raises ownership and lifetime issues unncessarily and the code is
cleaner with only a single access path for these data.

The code now treats the returned pointers as booleans.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7bc49ba..ace8896 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,8 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
-	GElf_Shdr shdr_mem, *shdr;
-	GElf_Ehdr ehdr_mem, *ehdr;
+	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
@@ -727,13 +726,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_flagelf(elf, ELF_C_SET, ELF_F_DIRTY);
 
-	ehdr = gelf_getehdr(elf, &ehdr_mem);
-	if (ehdr == NULL) {
+	if (!gelf_getehdr(elf, &ehdr)) {
 		elf_error("elf_getehdr failed");
 		goto out;
 	}
 
-	switch (ehdr_mem.e_ident[EI_DATA]) {
+	switch (ehdr.e_ident[EI_DATA]) {
 	case ELFDATA2LSB:
 		btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
 		break;
@@ -751,10 +749,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_getshdrstrndx(elf, &strndx);
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
-		shdr = gelf_getshdr(scn, &shdr_mem);
-		if (shdr == NULL)
+		GElf_Shdr shdr;
+		if (!gelf_getshdr(scn, &shdr))
 			continue;
-		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
+		char *secname = elf_strptr(elf, strndx, shdr.sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
-- 
2.30.0.478.g8a0d178c01-goog

