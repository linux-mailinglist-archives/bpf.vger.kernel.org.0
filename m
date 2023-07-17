Return-Path: <bpf+bounces-5089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476467561C8
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 13:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025202811A0
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DFCAD47;
	Mon, 17 Jul 2023 11:42:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A12A92C
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 11:42:09 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979EB10D5
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:42:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b8392076c9so50297041fa.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 04:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689594122; x=1692186122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7UHhFAQ1FaPs29fvZX7CYf1ico5jMHSKUYpX+oo8ek=;
        b=Vh2f2nU9VaVBZJD9ooQnVXSm4T5KSE53a1VWB6uNdNOZenJC/gVkO1VjvS6LAPaOmw
         R2iEjfb6mF8btLJcWWYCXcLMp2pGD5A/N+7NYA6T9pTRwQwP0IBpJgCQ8WiKIBsoJ4EP
         Wl0ZPZYxoW0iDBPHnJIun3XY302JfupNFwPVlHSRkg0KeXPiyGPoNlfW9jpYwDGBjYhy
         2kJpcRyG7wm+qKws+/QLoh3wztG4AzUYb9p/mrPNfL+qf/1jgI46tmpKeA6xyb+EsBQQ
         Cy1vFb+I1oDViGZJagA1Dl/tjIf0eUNrZrEyiE3LHRraLruiGguoPZ09oNvXeFq8CiI5
         beXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689594122; x=1692186122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7UHhFAQ1FaPs29fvZX7CYf1ico5jMHSKUYpX+oo8ek=;
        b=ACP4Kl7AqVooIinuxSQZ6TTaCF2M+KZaPFD/Ta2OmQtDmjBvQeytrfOFjix0Tr4Imv
         8CvrklNuOXxz77gUiyhKL0XCfpZ/N4HA8zOQ5Z7x0hS35ijtLl33UAEwMZ/MZosECKmZ
         6jxhgxpCwuhY0yIFs4DqhGVO2JtcQKQuwL6QfmNg3AikCwKZM1bECRKMgv+lbSl6QJFE
         g5++6a7O2r78P8XGLqR4r+K6r2U9RrG8Ljwj7mCJXYFZ+yi9GtC6mI0QdHzautIxrHdg
         2BmQKYftGM0Nlh0Ztb37pbzBRwd4H+rsu/MHWvMCANCf2Mhte1rmZ+qS+ummnDDH9BrF
         lPZQ==
X-Gm-Message-State: ABy/qLYgCgkH8eMyIwkeGKkk/5hufaGnP6MPBcdyT/uLJdlUTl01VAv7
	/lg1mKi6E2d9spu0DEiYCIVQgg==
X-Google-Smtp-Source: APBJJlGjRSDk4zBMgAQlu/4kYfZ+mQZFT+iyjVQxWs1snlZC2ZAnxz0Xq1LZL+x1qaKrzrLTAasB5g==
X-Received: by 2002:a2e:9ed3:0:b0:2b4:47ad:8c70 with SMTP id h19-20020a2e9ed3000000b002b447ad8c70mr7446271ljk.11.1689594121908;
        Mon, 17 Jul 2023 04:42:01 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c214900b003fbc9371193sm7946725wml.13.2023.07.17.04.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 04:42:01 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Brian Vazquez <brianvv@google.com>,
	Hou Tao <houtao1@huawei.com>,
	Joe Stringer <joe@isovalent.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [PATCH bpf-next 2/2] bpf: update uapi/linux/bpf.h docs on the batch map ops
Date: Mon, 17 Jul 2023 11:43:07 +0000
Message-Id: <20230717114307.46124-3-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717114307.46124-1-aspsk@isovalent.com>
References: <20230717114307.46124-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The map_lookup{,_and_delete}_batch operations return same values. Make
this clear in documentation. Also, update the comments so that this is
more clear that -ENOENT is a valid return value in case of success. (In
fact, this is the most common return value, as this is reasonable to do
map_lookup_batch(MAX_ENTRIES), which, in case of success, will always
return -ENOENT.)

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/uapi/linux/bpf.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 600d0caebbd8..9e6e277bedab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -632,17 +632,19 @@ union bpf_iter_link_info {
  *			returning the lock. This must be specified if the
  *			elements contain a spinlock.
  *
- *		On success, *count* elements from the map are copied into the
- *		user buffer, with the keys copied into *keys* and the values
- *		copied into the corresponding indices in *values*.
- *
- *		If an error is returned and *errno* is not **EFAULT**, *count*
- *		is set to the number of successfully processed elements.
+ *		On success, up to *count* elements from the map are copied into
+ *		the user buffer, with the keys copied into *keys* and the
+ *		values copied into the corresponding indices in *values*.
  *
  *	Return
  *		Returns zero on success. On error, -1 is returned and *errno*
  *		is set appropriately.
  *
+ *		If an error is returned and *errno* is not **EFAULT**, then
+ *		*count* is set to the number of successfully processed
+ *		elements. In particular, the *errno* may be set to **ENOENT**
+ *		in case of success to indicate that the end of map is reached.
+ *
  *		May set *errno* to **ENOSPC** to indicate that *keys* or
  *		*values* is too small to dump an entire bucket during
  *		iteration of a hash-based map type.
@@ -655,15 +657,15 @@ union bpf_iter_link_info {
  *		**BPF_MAP_LOOKUP_BATCH** with two exceptions:
  *
  *		* Every element that is successfully returned is also deleted
- *		  from the map. This is at least *count* elements. Note that
- *		  *count* is both an input and an output parameter.
+ *		  from the map. The *count* parameter is set to the number of
+ *		  returned elements. This value can be less than the actual
+ *		  number of deleted elements, see the next item.
  *		* Upon returning with *errno* set to **EFAULT**, up to
  *		  *count* elements may be deleted without returning the keys
  *		  and values of the deleted elements.
  *
  *	Return
- *		Returns zero on success. On error, -1 is returned and *errno*
- *		is set appropriately.
+ *		Same as the BPF_MAP_LOOKUP_BATCH return values.
  *
  * BPF_MAP_UPDATE_BATCH
  *	Description
-- 
2.34.1


