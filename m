Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2687B10223F
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKSKuS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 05:50:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41011 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfKSKuS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 05:50:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id b18so21791942wrj.8
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 02:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=v3SR/Wv2ZKizQBTT/BCaE/dXsNbERQRJO9ye1A6QXTc=;
        b=iIqi5xs9y/GWsQD3CdgwmpBo8DbLB9/cDLLtKYIdzOrZB9ZidsCOQACBiDjAuCL0eG
         grwC9hNskZie0VqQJg0XSUwQjVc2WFOwhLhsf05f7WY0YEyVUDo4xQhCIS3iaGyRyXXj
         pkXhxnx2VGc9WnDZxhOU0hxeP+s0GFgH+cd2xUb6zSjoOnRiX+tj7kKPLQsmVq3V6j7t
         mWo/iZd3R3/kBMhb9v7WK85KyrLF+IOluu5fJKlsHlOaNq6ETPpBEm0glhNlgwsVqIdn
         6hPejd5w2ZBn2ysNdhqWMWxd69dggG4GerIV2ncGWR9WEHRO70d/Ag7/jWoKUt7kqc2d
         bPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v3SR/Wv2ZKizQBTT/BCaE/dXsNbERQRJO9ye1A6QXTc=;
        b=sYx69LQXDoDooXMtACLpQpb7iXD2GTAgFwXM4aNRA3/jEbz0ORgk7YRfqMzNEWTRLZ
         6I6INFbIiioWfqcAEASxf5D8iPR05XXCPl49zCPzEbcWTfLWDZZ4FbKZ3F3NUdCnMaJv
         24sGqvbdbBOa+mTVivIk/qfVNSdYgZ73HKBY9dXFD4c6IHjUBRLFU2OOx30dpbNbr18L
         9bUV/+Qw+UU28OMAfUK+5Y0FVsJx0px5+Qgvklgp5ud+w1kiONY6MibCEeDcoiOWIQYZ
         U9a1hPXyjEn30TG/cILBYM44fjnjtXn57rrPUMrVHI2pW4cI2mOGPXvRBqiUAlkgs74C
         xWaw==
X-Gm-Message-State: APjAAAX9YCi+7fYXoQNAKO7pAI5LuLBPIrZfiTTAp1tfd0V4L7JAKJN6
        X86B0W6CjMffnNhet+Xx6Vjyow==
X-Google-Smtp-Source: APXvYqwNaA49+RpaL1QNuDPtanP9i7V62tlt1DJYekp69Dex9AsqnAX9zFR0Z9qcRvyjc96tO40nvQ==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr18468274wro.348.1574160616374;
        Tue, 19 Nov 2019 02:50:16 -0800 (PST)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g5sm2646708wma.43.2019.11.19.02.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 02:50:15 -0800 (PST)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH bpf-next 0/2] selftests: bpftool: skip build tests if not in tree
Date:   Tue, 19 Nov 2019 10:50:08 +0000
Message-Id: <20191119105010.19189-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The build test script for bpftool attempts to detect the toplevel path of
the kernel repository and attempts to build bpftool from there.

If it fails to find the correct directory, or if bpftool files are missing
for another reason (e.g. kselftests built on a first machine and copied
onto another, without bpftool sources), then it is preferable to skip the
tests entirely rather than dumping useless error messages.

The first patch moves the EXIT trap in the script lower down in the code,
to avoid tampering with return value on early exits at the beginning of the
script; then the second patch makes sure that we skip the build tests if
bpftool's Makefile is not found at its expected location.

Jakub Kicinski (1):
  selftests: bpftool: skip the build test if not in tree

Quentin Monnet (1):
  selftests: bpftool: set EXIT trap after usage function

 .../selftests/bpf/test_bpftool_build.sh       | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

-- 
2.17.1

