Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D91758D6A7
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 11:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbiHIJnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236324AbiHIJnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 05:43:06 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138C222BD;
        Tue,  9 Aug 2022 02:43:05 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BEAB6FF808;
        Tue,  9 Aug 2022 09:43:00 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-usb@vger.kernel.org, bpf@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 0/2] USB: core: add a way to revoke access to open USB devices
Date:   Tue,  9 Aug 2022 11:42:58 +0200
Message-Id: <20220809094300.83116-1-hadess@hadess.net>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF list, first CC: here, I hope the commit messages are clear enough to
understand the purpose of the patchset. If not, your comments would be
greatly appreciated so I can make the commit messages self-explanatory.

Eric, what would be the right identifier to use for a specific user
namespace that userspace could find out? I know the PIDs of the
bubblewrap processes that created those user namespaces, would those be
good enough?

Changes since v2:
- Changed the internal API to pass a struct usb_device
- Fixed potential busy loop in user-space when revoking access to a
  device

Bastien Nocera (2):
  USB: core: add a way to revoke access to open USB devices
  usb: Implement usb_revoke() BPF function

 drivers/usb/core/devio.c | 79 ++++++++++++++++++++++++++++++++++++++--
 drivers/usb/core/usb.c   | 51 ++++++++++++++++++++++++++
 drivers/usb/core/usb.h   |  2 +
 3 files changed, 128 insertions(+), 4 deletions(-)

-- 
2.37.1

