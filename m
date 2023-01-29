Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8E67FF91
	for <lists+bpf@lfdr.de>; Sun, 29 Jan 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjA2Oig convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 29 Jan 2023 09:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjA2Oif (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 29 Jan 2023 09:38:35 -0500
X-Greylist: delayed 727 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Jan 2023 06:38:30 PST
Received: from bufferz9.csloxinfo.com (bufferz.csloxinfo.com [203.146.237.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B94E46EAF
        for <bpf@vger.kernel.org>; Sun, 29 Jan 2023 06:38:30 -0800 (PST)
Received: from mailx1-7.csloxinfo.com (unknown [10.20.140.7])
        by bufferz9.csloxinfo.com (Postfix) with ESMTP id 3BB1723C6C95;
        Sun, 29 Jan 2023 21:26:22 +0700 (ICT)
IronPort-SDR: 63d6820d_E4btPlvOLCihjrqjfvVshODT4fZuqt80XNIac4TSoC8lr4X
 dbv3pXpBnbQaEK91gL/mDRYiFB7UQfYgmGRawiQ==
X-IPAS-Result: =?us-ascii?q?A0BS6QCAgdZj/zLBqsuBbIYmjXmGFpN0XoQhgg+ESoF9D?=
 =?us-ascii?q?wEBAQEBAQEBAR0wBAEBgVQBgygFA4UpJksBBgEBAQEDAgMBAQEBAQEDAgUDA?=
 =?us-ascii?q?gEBBgSBHYV1h00jDX8XE4YhAgGnJG6BNBoCZYRdnGOJc4kaFgaCDYFLgj03P?=
 =?us-ascii?q?msaAU2HAp4ggTl1gSUOgUaBDwIJAhFGDx9ANwMzER03CQMLbQo/FCEIDkorG?=
 =?us-ascii?q?hsHGiRIKiQEFQMEBAMCBggLAyICDSQEMRQEKRMNEhUmIkcJAgMiYgMDBBgNA?=
 =?us-ascii?q?y0JPwcVESQ8BxBGOAUCDx83BgMJAwIfT4EgDRcFAwsVKkcECDYFBlESAggPB?=
 =?us-ascii?q?Q0FCgYDI0MOQhgfATMOBQYwPBoLDhEDUB59MgQvgUoYVZ1ogyWBZ5R2jROhZ?=
 =?us-ascii?q?AcDg3WXXIh0GjIYgQaCW4xihjAIFgOECo15Q5cMolIghDGCMFCBZ3AVggeBa?=
 =?us-ascii?q?gMZhVqIbJYqQYEHCYwjAQE?=
IronPort-Data: A9a23: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
 iT4BIf45f4RgRwfGfkk3OneYw==
IronPort-HdrOrdr: A9a23:FD8EvqDzkCx1PvXlHemz55DYdb4zR+YMi2TDpHoBKyC9E/b4qy
 nAppgmPHPP4wr5O0tPpTnjAsa9qBrnnPZICOIqUItKKTOW21dAQrsJ0WKb+V3dJxE=
X-IronPort-Anti-Spam-Filtered: true
Spam_Positive: LL
X-IronPort-AV: E=Sophos;i="5.97,256,1669050000"; 
   d="scan'208";a="459383829"
Received: from unknown (HELO mailx2.bestidc.net) ([203.170.193.50])
  by mail-1.csloxinfo.com with ESMTP; 29 Jan 2023 21:26:21 +0700
Received: from mailx2.bestidc.net (localhost.localdomain [127.0.0.1])
        by mailx2.bestidc.net (Proxmox) with ESMTP id 523EA49297;
        Sun, 29 Jan 2023 16:37:58 +0700 (+07)
Received: from mail.thaipaiboon.com (mail.thaipaiboon.com [203.170.193.111])
        by mailx2.bestidc.net (Proxmox) with ESMTPS id C86704928D;
        Sun, 29 Jan 2023 16:37:57 +0700 (+07)
Received: from mail.thaipaiboon.com (localhost [127.0.0.1])
        by mail.thaipaiboon.com (Postfix) with ESMTPS id 7EBF0C00C303A;
        Sun, 29 Jan 2023 16:37:57 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by mail.thaipaiboon.com (Postfix) with ESMTP id 4EE44C00BCF89;
        Sun, 29 Jan 2023 16:37:57 +0700 (+07)
Received: from mail.thaipaiboon.com ([127.0.0.1])
        by localhost (mail.thaipaiboon.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z60UvRLfMfcu; Sun, 29 Jan 2023 16:37:57 +0700 (+07)
Received: from [192.168.10.100] (unknown [160.152.44.246])
        by mail.thaipaiboon.com (Postfix) with ESMTPSA id BEFD0C00C364C;
        Sun, 29 Jan 2023 16:37:45 +0700 (+07)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Re: Request Partner
To:     Recipients <banpotl@thaipaiboon.com>
From:   "Mrs. Reem E. Al-Hashimi" <banpotl@thaipaiboon.com>
Date:   Sun, 29 Jan 2023 10:37:23 +0100
Reply-To: nationalbureau@kakao.com
Message-Id: <20230129093745.BEFD0C00C364C@mail.thaipaiboon.com>
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_MR_MRS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Sir/Ma,

My name is Mrs. Reem E. Al-Hashimi, The Emirates Minister of State  United Arab Emirates.I have a great business proposal to discuss with you, if you are interested in Foreign Investment/Partnership please reply with your line of interest.


PLEASE REPLY ME : rrrhashimi2022@kakao.com

Reem

