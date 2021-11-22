Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FED459087
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 15:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhKVOu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 09:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238653AbhKVOu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 09:50:58 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B19C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:52 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id iq11so14019618pjb.3
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl3vpE4uSoJ1lNFGbYPq1yheIYEHx2gnaOjUDnYpK4g=;
        b=dfSySG6ho3EB3n1lWpSN+2/HYFi5dDiCOw++7/Cg6CvDe/28FBVxrEiDHZfKCIQ/4e
         Zqa9z+1iYLvs3Ew2qCGNL1d51esI0ruc8pYSliVjO0zo6m/yBKG6u50BG+HaF2L3a9tJ
         58ADFXKn8g/lFZ+9fTqoFaW+4/9myuc8V8ddGVsmFKh/8Jp3Bj2Xr1c91spRTFMTvbOH
         Zjawxh4Nhq1xK3dMAajEgkc/FlglFiXdOq/LKzYNqhobvdNmKIAs0TTLqAU3YQ+E21UY
         PsQ0K+8Jrs20NUXylnGLYmIlBb4z31AUJxSG+EX7p9y8ndQfV4B8td3Vw4fjDahvnBcW
         4nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl3vpE4uSoJ1lNFGbYPq1yheIYEHx2gnaOjUDnYpK4g=;
        b=1Cp66T1vtzAlaJXH5stiZtKrRu+xD3MzjCm7p4eExw7wH8/rxIRKVCcZR4oe35DHwt
         VuLAMN7DD5FkKe4mU6lZHi1C0TLOh0k2RfHli3QX+cfTMoelG2SHjtW5yGckbnfzIQcA
         /dTmylY+hphOVqKLxSjrBrhslGzqoerqRVRsqp1U3ACjGMSe02hA70d9ARBIZVzvpeCp
         9lCG/MgEfOMbrt7jY1aSg/tYneaLpLCPAeYLUDWZoSS/gjL9YsQi41KHfC/bbQH+dGac
         oqVVTvroT2mA4NP2qEdzE7lzfZ4Py8bbTRBXjxYg7ueCG1Q3fv7cvPyqUTlneSQwL3LE
         dAwg==
X-Gm-Message-State: AOAM5325sh73njDqMGt20wM0yKjG5lx2xnx9EGME5uOxVu4m+m4IveGv
        b+Dc7ItUYhSSZZD3n3umPvTvLpOpiJ8=
X-Google-Smtp-Source: ABdhPJzaCmP8WHiLpbf+td/b5yrr7GgaOl2tc+XPYgpE75upjpcjWL6b0yuHyNVRJJrvhFSJ7BlUIg==
X-Received: by 2002:a17:90b:3b45:: with SMTP id ot5mr31909093pjb.235.1637592471307;
        Mon, 22 Nov 2021 06:47:51 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id p3sm7916514pjd.45.2021.11.22.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 06:47:50 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v2 2/3] bpf: Fix bpf_check_mod_kfunc_call for built-in modules
Date:   Mon, 22 Nov 2021 20:17:41 +0530
Message-Id: <20211122144742.477787-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122144742.477787-1-memxor@gmail.com>
References: <20211122144742.477787-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; h=from:subject; bh=xNSl+3FwNT93EiYJrxmwwFJVjiwwUUuv8e9SKjEpdKA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhm619BmjZ5XvWI7fGS52h/VacKhTHupuuOM2kL+wb gxkdHnaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZutfQAKCRBM4MiGSL8RyuGYD/ 9AR8IVrrgvy71luxr/exOwRpUo8rOcoOqMelE00PAeE/p6A/sjff+lANZ51EKhSNy6u9wx7DYn4Wma v0B0vwG+GOWMTIfZaWKiSPYy03IenZ9rntB+nttGXPthGZPykn8nkoE+uhC6zGX1RaH7wMfrb3bstU dcmMU3vtDvlU0hGnyYb7qbdnzWVxgisR9YYvgqhEXmBAMkPbmXiZPz3iOXsVmDp5jJnQRaY2zFOV1a iW5Ia0Gx3yjU22cwGZ63lajWcVWZnzXi7BiW4LmhNK9Jq70SrIkOInc7J+cOhStnTfZeQzWgMUQBgU v/9WHiWIDBV7Emnj/tt/lUc8IEvm77RkBKfsZFAY2KRM8tljdEvELyP+BcgA2DXk5+H4PQWOpFL12F glZKXpatj9cR9QGKosaUtlS7nwF3fc/vSKQ1hs2lNqYX8vg2d5u6vdenEHEHd/bzp6TumOZDzHFpa7 nxIKJpoGGl0qvQzRL0agb9NkA7AtfKeX8vbpZQtc9o8HIQCO98fr9Ls1Cq6G3bCxNBpm7Q4mwQKFLE VS2P4o/uVN+B+Dy1dC7a57//y3a9pcItDIgVOokJtZ6JgiRTKws3K82lu6S8RkoalE+bWa2nhauVuX QxpjOUi84qxQvQZbbouh2R0/48RAlH5QzimrpjKbWueg6mCx6xzLdjgKG3Sw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When module registering its set is built-in, THIS_MODULE will be NULL,
hence we cannot return early in case owner is NULL.

Fixes: 14f267d95fe4 ("bpf: btf: Introduce helpers for dynamic BTF set registration")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ea3df9867cec..9bdb03767db5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6371,8 +6371,6 @@ bool bpf_check_mod_kfunc_call(struct kfunc_btf_id_list *klist, u32 kfunc_id,
 {
 	struct kfunc_btf_id_set *s;
 
-	if (!owner)
-		return false;
 	mutex_lock(&klist->mutex);
 	list_for_each_entry(s, &klist->list, list) {
 		if (s->owner == owner && btf_id_set_contains(s->set, kfunc_id)) {
-- 
2.34.0

