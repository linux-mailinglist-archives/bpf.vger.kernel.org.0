Return-Path: <bpf+bounces-15205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A37EE769
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FB04B20D03
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6D48CDD;
	Thu, 16 Nov 2023 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Obwa6NhB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A68ED5B
	for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc3216b2a1so10798045ad.2
        for <bpf@vger.kernel.org>; Thu, 16 Nov 2023 11:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700162489; x=1700767289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcOGCvfEagiw1YdvVb5+RIJk8AKqAaDYL4V7FygIVew=;
        b=Obwa6NhB3UvqEPYIY/eSPoywDnIy6qI94KyzaKOwFxO0bvBS8qUe28NohbTj6++iDz
         kChhiWkx+A683O/yoCYMHL6z8K8RrRJIaBQfNOJOwI/njVXcAODwOCKfdy10liYXLQCN
         bQQPOxHFJ/Kzudt9tTrE6JIeD4Jlz/yny339c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700162489; x=1700767289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcOGCvfEagiw1YdvVb5+RIJk8AKqAaDYL4V7FygIVew=;
        b=norjNjN0YAv5ACIuOMB9TKGkNaVz5mV6iK6oPPad7r8m+beBkNdo0mDRFZj4ytG3SS
         e/ffmCKWJK5FsatUrh2Cp+/uwh1aeRmYYfQ7Zf/a/jZ0oqetT+Uqzb/jfgajtRot/j7V
         jld5IPEL1Kdafw2nnJcIDbE59jdullwOouv5RMYaZ54VKuUU9az4tipn3UnC66Q/5YEx
         EaMNTBW738c7OW3yMHCus2EO3aeLi8nwHQeKzY+S7AJVSjHdlybZwxYaAHcJGknOLHpH
         OpdfgXRjIQiy0QOkOKF+GciLiNQRztAZP48glwemUQiHg0KidIJaBlXtiF7OGe0lT9ID
         ElXA==
X-Gm-Message-State: AOJu0YzWm0wpEroxgYpJBZsKQIhTgKwcE23RFOzCeXxDKYfYmzvR5VMT
	RJyOhsdCfNkoxtGYDOvlmu0/ag==
X-Google-Smtp-Source: AGHT+IGaGl07eSgYy3o8f6edP1SkNwCS66RrUaUOhWuRJ+oeJxlMHbJLhbzYWUfIGXmL8cR8NFc1fQ==
X-Received: by 2002:a17:902:eccb:b0:1cc:3c2f:9c41 with SMTP id a11-20020a170902eccb00b001cc3c2f9c41mr11600739plh.23.1700162489608;
        Thu, 16 Nov 2023 11:21:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001c32fd9e412sm28083plc.58.2023.11.16.11.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:21:28 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
Date: Thu, 16 Nov 2023 11:21:23 -0800
Message-Id: <20231116192127.1558276-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116191718.work.246-kees@kernel.org>
References: <20231116191718.work.246-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=keescook@chromium.org;
 h=from:subject; bh=RC/7LXkyyLguxbbh56shJCtsntlpj0v42+8lbCHyU+Q=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlVmu1a6YGdzhkpS/cBY9OTj5JYo8XAMY6N0Jto
 saH/INeq++JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVZrtQAKCRCJcvTf3G3A
 JmvvD/4hr2r1X4hdNRSGjLQ0H9OzAANSFcbnzJfaOanKtWw5cPHnrunF87wYSMyErB4/oiEJRLs
 0HkPFaj2BH5MXTVv4dNNPgNWv5sV7AbzxG+f3fdi3csPn3hTlnA4J8ugnwhU3piG8gYUOWP6vaT
 pf2p3JEknP9h4DK51GSgbULEBrBYo1PRWXKa2joQA3vkfWjunJoR0FEiNFlzm5LCYqb3YhBtws2
 qofYsgxWF2wfkKO5nKlGyFyarUQfJ2RVLsIi+UMDpBVzO42U3VZyQlhkTcg7EkmOtudofwdBXK4
 0+Zm3jPk2zNGJfle1nY4jU9/mDukzZNJUhKagSnXYbf5JjntQ7n4HGFwaX9TsjyVmzhTrQ7gdqH
 krL0I5ky99HtHXMTUGWqyOUxwp1/VVdvp1umcCodYwkiptU0kKhbx96z/sFfT293wXWmcJHrilQ
 QVO4JiJSrQalFRzNYTvKQA+liozKhtf+rCDc7PfrRykroARPwmlXWBN8MXyEHTG8usj0LM/5lqE
 TLTHGNwFkf2LPoPdSdt1FYYpM+d8aCyWbqWuAryypw63HLRYP6tMyXNhMc36X9s3wo4404dXooj
 /EGJXy98yYJx8ykG85Ru2S1uYthlhKQQ2MpUBixq+dLxTB6qtI9vJoywzOpi3tqIINg3BntSh2t jIEaboOkD87aMGQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..37353901ede1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -850,16 +850,16 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const void *ns)
 {
-	size_t len;
+	ssize_t len;
 	char *p, *name;
 
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (len < 0) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
-- 
2.34.1


