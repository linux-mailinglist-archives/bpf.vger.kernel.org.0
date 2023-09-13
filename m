Return-Path: <bpf+bounces-9945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55EE79F000
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E031C20EC2
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61941F95F;
	Wed, 13 Sep 2023 17:13:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100D1F952
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 17:13:53 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502A98
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:13:53 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56c2d67da6aso6749586a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625232; x=1695230032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+xrco406OitaU7JCJ0p7zlJRKXWCj4JGU0SDWBMH+0=;
        b=0DjqBy8tuzef5xXTGLnDuyzsFYLRFkzQcGuIpP9qb4juFaLXZ7C+6I9ZXtKH+UWlSJ
         v3ZTpmm3yvLzLOJClPnn71ew17pyW/i/PhW5oyLNqXQztVFF/RuK+mAALI9ACIx6zzKv
         0z8uMj7a8kUApZYhNleQPjJsTxoUDd8NS17LZEdZNWkOCjFdmiNwIZCk/+SZfNu5j9BK
         IHiZg6ynyUL9mCv7RNuqGmlBK6MvbiNglx306vVOAYhVQfmiD9aXZBZATomDllw8gDvL
         M9HtEET5MWWKJLQOSkX40b5+GueVba031mWH9RApYuuJnlumTB9C8ernidvNYNticEce
         0Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625232; x=1695230032;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+xrco406OitaU7JCJ0p7zlJRKXWCj4JGU0SDWBMH+0=;
        b=TFkSj9+MfxduJF7F1z1B48qkBj1qvn83GMYOtgNuIkO+Zc/tRmOF1i+ptZNBhArOdK
         u9qn4X2iOfiw8AWrzagNjDGtPNCa/zXrLye+DbDILMkpTp+v9bQU/W8GnkHfzOP0/CXV
         ubMyP3O4YABKG117LWgCaomlbZ5TsUkDsdGY4gAaqk1snsMDikCDUBoOPP3raHxFSX9A
         Z02THxUndyXujKF061notGk26lMIXF9zWun5NqtEuNliLzP0aV+lhn6Go63C27ahOHIs
         oiUIJ4RFnu96tpzSzK6/a4yboKEdMoFm7uPvsN9KtNudtzpkCcQRITmnHAFjz1u8VjHR
         QayQ==
X-Gm-Message-State: AOJu0Yw1u4xnu8cSkBiijCZYKKs38BxkHoI+O45j+YuuOvPO7kMc/MQH
	qr8h6IulllZwxJg2K1coH0EHFlOAubZ9x0x4tnTQHQ4+BAb2nr7e1zOZ0pniYDuwAz5CEX465+N
	M4KRQAVEuX+ypixQKNEIOKKiH5uHZAlHN/+YzvarGdjPOICv3/A==
X-Google-Smtp-Source: AGHT+IGvDbg0SG3OGXWvTvdb22f/XDnLzIHHqYOWeDTBWGVnWRaS4pm6cSye3Ms8CEI5bH1cK0tzY/c=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:3751:0:b0:577:45b2:d8b9 with SMTP id
 g17-20020a633751000000b0057745b2d8b9mr75971pgn.4.1694625232407; Wed, 13 Sep
 2023 10:13:52 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:13:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913171350.369987-1-sdf@google.com>
Subject: [PATCH bpf-next v2 0/3] bpf: expose information about netdev
 xdp-metadata kfunc support
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend netdev netlink family to expose the bitmask with the
kfuncs that the device implements. The source of truth is the
device's xdp_metadata_ops. There is some amount of auto-generated
netlink boilerplate; the change itself is super minimal.

v2:
- add netdev->xdp_metadata_ops NULL check when dumping to netlink (Martin)

Cc: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>

Stanislav Fomichev (3):
  bpf: make it easier to add new metadata kfunc
  bpf: expose information about supported xdp metadata kfunc
  tools: ynl: extend netdev sample to dump xdp-rx-metadata-features

 Documentation/netlink/specs/netdev.yaml      | 21 ++++++++++++++++++++
 Documentation/networking/xdp-rx-metadata.rst |  7 +++++++
 include/net/xdp.h                            | 19 ++++++++++++++----
 include/uapi/linux/netdev.h                  | 16 +++++++++++++++
 kernel/bpf/offload.c                         |  9 +++++----
 net/core/netdev-genl.c                       | 12 ++++++++++-
 net/core/xdp.c                               |  4 ++--
 tools/include/uapi/linux/netdev.h            | 16 +++++++++++++++
 tools/net/ynl/generated/netdev-user.c        | 19 ++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h        |  3 +++
 tools/net/ynl/samples/Makefile               |  2 +-
 tools/net/ynl/samples/netdev.c               |  8 +++++++-
 12 files changed, 123 insertions(+), 13 deletions(-)

-- 
2.42.0.283.g2d96d420d3-goog


