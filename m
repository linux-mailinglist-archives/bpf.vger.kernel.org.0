Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE521621AA
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRHq7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 02:46:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35425 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgBRHq7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Feb 2020 02:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582012017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=L0KwBipFTk/tXRKVos7TVVzcI+dPws7IUmcDi9hmKr4=;
        b=PGpJe0F8UanuRS+M5KQUyeovYd4cs7iz1dBAEYFB4kvTWSZV/FUXViTZfUTc+xuOYVKSkM
        7gzBzX8pS3RgJtk5ce3SksgCtVKcNk3ZkoaKpufhLeMhBSf2nmXxbEBUqSDeII0P7FbF5V
        2Tpszd1Ou17YrEGAcAI/VfO7/YrZtXQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-b-Qq58r-Pi-Kt1-bNrPM4g-1; Tue, 18 Feb 2020 02:46:56 -0500
X-MC-Unique: b-Qq58r-Pi-Kt1-bNrPM4g-1
Received: by mail-lf1-f72.google.com with SMTP id u2so2003855lfk.3
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2020 23:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0KwBipFTk/tXRKVos7TVVzcI+dPws7IUmcDi9hmKr4=;
        b=gQKGX7o6C9j5NvknO+iGNBj5si8MNIfDUO6TwMgsxUVLnolpq5hvE/Lq7Hf4o9IdnJ
         LmsJ43OzOoPkU0O6n+aSyy2E2I53HyMzF8tO+/AWZoFTfwXujeEs59CduD83MLjj8cEA
         jM59dw36HLMPguJWQdlYeD5lY/OmDasYrxBS/nwU3ZoxAaZgor9Ebni+vVsHaG0e1Is2
         PdDdpF4yeL04a5tfi3S4At6kJAr/skStwQUlc5wAI+GG+pIUfJJK6q1plsHOCk6k6RHU
         USEE5wogqQ3lpukEgSt/LhnbJUUnxpIoh5TxueTmh67iahgUO1lAAhJ2dghfauNTuzd7
         icfw==
X-Gm-Message-State: APjAAAWgVFKWWmkwQUBcfDTw9eJz6lYY/nXIZ/X85V1CuVbysB6ydzfQ
        4JCnSZVY6KQG8RAOUp3KXRbI8q2zCBnZu2x6rL76Mru4Xw3To+yUXeBum37QzGaO6/OA7KuJEkb
        AGMfeIMgH+C8k
X-Received: by 2002:ac2:5e71:: with SMTP id a17mr9769196lfr.181.1582012014661;
        Mon, 17 Feb 2020 23:46:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzqe1aYSFI6f3NrR1ycP6OPMPR8EDPcyyzjtIF1r+CmR0ZJFLoMsJNm0YQjhhTkYO6WxTOTRQ==
X-Received: by 2002:ac2:5e71:: with SMTP id a17mr9769181lfr.181.1582012014348;
        Mon, 17 Feb 2020 23:46:54 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id x18sm1663475lfe.37.2020.02.17.23.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 23:46:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D4D22180365; Tue, 18 Feb 2020 08:46:52 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH bpf] uapi/bpf: Remove text about bpf_redirect_map() giving higher performance
Date:   Tue, 18 Feb 2020 08:46:21 +0100
Message-Id: <20200218074621.25391-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The performance of bpf_redirect() is now roughly the same as that of
bpf_redirect_map(). However, David Ahern pointed out that the header file
has not been updated to reflect this, and still says that a significant
performance increase is possible when using bpf_redirect_map(). Remove this
text from the bpf_redirect_map() description, and reword the description in
bpf_redirect() slightly.

Fixes: 1d233886dd90 ("xdp: Use bulking for non-map XDP_REDIRECT and consolidate code paths")
Suggested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/uapi/linux/bpf.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1d74a2bd234..7a526d917fb3 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1045,9 +1045,9 @@ union bpf_attr {
  * 		supports redirection to the egress interface, and accepts no
  * 		flag at all.
  *
- * 		The same effect can be attained with the more generic
- * 		**bpf_redirect_map**\ (), which requires specific maps to be
- * 		used but offers better performance.
+ * 		The same effect can also be attained with the more generic
+ * 		**bpf_redirect_map**\ (), which uses a BPF map to store the
+ * 		redirect target instead of providing it directly to the helper.
  * 	Return
  * 		For XDP, the helper returns **XDP_REDIRECT** on success or
  * 		**XDP_ABORTED** on error. For other program types, the values
@@ -1610,12 +1610,6 @@ union bpf_attr {
  * 		one of the XDP program return codes up to XDP_TX, as chosen by
  * 		the caller. Any higher bits in the *flags* argument must be
  * 		unset.
- *
- * 		When used to redirect packets to net devices, this helper
- * 		provides a high performance increase over **bpf_redirect**\ ().
- * 		This is due to various implementation details of the underlying
- * 		mechanisms, one of which is the fact that **bpf_redirect_map**\
- * 		() tries to send packet as a "bulk" to the device.
  * 	Return
  * 		**XDP_REDIRECT** on success, or **XDP_ABORTED** on error.
  *
-- 
2.25.0

