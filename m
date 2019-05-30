Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977AF2F8BF
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfE3Ivb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 04:51:31 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:33489 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE3Ivb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 May 2019 04:51:31 -0400
Received: by mail-pg1-f173.google.com with SMTP id h17so1637665pgv.0;
        Thu, 30 May 2019 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9yPNki8tFmIgDjX+2v/i+yBX4YbiShnd6bPfUYaPNcY=;
        b=bFXjyuJzEziH0nuuB8bYDwiEuyEkZjkBk3ZzpHUpSMKjUkJc5ctwmzPPoENpZjfGcn
         QF8I2/ImQRSTLJjjiCAP2YDQY65pWycuP2uBDtqLC1AbrfAZVOMutCwt4KZdbBfJvxr6
         DvrQZUsDKo3N2h3X0l6CVvmyj9r685BsnPXNFky/0ppnTK76TyBUE+idc9175k1zCLL+
         e06KDeKwzf6F5y1aaTmg6A7dAYabxHhGCDAUEOQknBEyXwDPybZ6AilZdIoD+/IqAy8d
         EVp5FzU1vntuD/LgnzC71HcgqzMhJGNW+BTSzlnKP6aog68gQEu91tYV8idhS1mE+h5j
         u43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9yPNki8tFmIgDjX+2v/i+yBX4YbiShnd6bPfUYaPNcY=;
        b=PIhXSHTxSpNBc9T9V4XrgTBB6IjjTPEsnPwyMSxQZCnil8/jr+AEF3OVcuZburTTQ9
         rr2YiWoqhKUfzvSLhQDhmsGyj3LtQuNYgCPWxVQ7caFxlAvVzVaRxmVwGKH6cfKWS9ek
         PW65EbwRRO77s9yH91LnxEDM9lO+8XXl7HtXby9qtgNgAkKX6YqKYOS8axuMBXjSNDvX
         fwFFAqHTgSgAt6pnC3LgZHPpoJr/0jvyH9HYQKmknLcukRBKXVFHy/YVQF1Lc3XSkCIc
         OLY6WK0K1KwkQ3cv2qJccxp/xXSlI8Huw5gUN6c1aB9fnpHJaZKMgVdGUWuOGxp9pPtn
         7fyg==
X-Gm-Message-State: APjAAAXWnS0QuESdwizwIriuE5D0A2s/y6Hs87Y9oR5sIEuYejzYhREq
        lUd0fOaBQKFHSyXWBjxFhOI=
X-Google-Smtp-Source: APXvYqx9XdArytw1HgFQ+Cty8TFXJEMG9A1YWtTO99CkXPQIYGmKOANGeO5dkNBHfkmV5Tnue+57Dw==
X-Received: by 2002:a65:62d8:: with SMTP id m24mr2755254pgv.141.1559206290397;
        Thu, 30 May 2019 01:51:30 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q28sm2405694pfn.106.2019.05.30.01.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 01:51:29 -0700 (PDT)
Date:   Thu, 30 May 2019 16:51:06 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Subject: [PATCH v2] hooks: fix a missing-check bug in
 selinux_sb_eat_lsm_opts()
Message-ID: <20190530085106.GA2711@zhanggen-UX430UQ>
References: <20190530035310.GA9127@zhanggen-UX430UQ>
 <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
returns NULL when fails. So 'arg' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ec702c..5a9e959 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 						*q++ = c;
 				}
 				arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
+				if (!arg)
+					return -ENOMEM;
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
