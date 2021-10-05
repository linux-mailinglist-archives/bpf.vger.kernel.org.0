Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523A2422F6A
	for <lists+bpf@lfdr.de>; Tue,  5 Oct 2021 19:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhJERyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 13:54:14 -0400
Received: from esa.hc5583-2.iphmx.com ([216.71.137.146]:34610 "EHLO
        esa2.hc5583-2.iphmx.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229523AbhJERyN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 13:54:13 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Oct 2021 13:54:13 EDT
X-IronPort-RemoteIP: 160.153.247.227
X-IronPort-MID: 9158
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: None
X-IronPort-MailFlowPolicy: $ACCEPTED
IronPort-Data: A9a23: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
 +s9qxrq/qesabe4VoMDQASo+oZ1XDXcWDDB4Q==
IronPort-HdrOrdr: A9a23:GhKBJqOD/kIfbcBcTtSjsMiBIKoaSvp037BN7SFMoH1uHPBw+P
 rDoB1273XJYVUqN03I8OroUJVoJ0m2yXcf2+Qs1M2ZLWrbUROTXeNfBNfZsljd8lbFltJg6Q
 ==
X-IronPort-AV: E=Sophos;i="5.85,349,1624338000"; 
   d="scan'208";a="9158"
X-MGA-submission: =?us-ascii?q?MDFOwCk9QuFpiGan6YFSB9KfeHLjNt8FlzyIoY?=
 =?us-ascii?q?pYNBCzAH0KTWahvYQ+isJloPmY4k6+bmSNulEdGZSzR5xPkbjYDnVpub?=
 =?us-ascii?q?Wc1ES32b26axbBFoWTAIsImzmRix0X0i7fH+oXRwJnm6z5Dq/PrpimTj?=
 =?us-ascii?q?aq?=
Message-Id: <3d5ec4$8u6@ob1.hc5583-2.iphmx.com>
Received: from ip-160-153-247-227.ip.secureserver.net (HELO User) ([160.153.247.227])
  by ob1.hc5583-2.iphmx.com with SMTP; 05 Oct 2021 12:45:07 -0500
Reply-To: <rev_peter200421@yahoo.co.jp>
From:   "Admin" <infor@trendgraphix.com>
Subject: RE = Congratulations_ _
Date:   Tue, 5 Oct 2021 19:45:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

WhatsApp Admin

Congratulations

Your email has won $1 million United States Dollar ($1,000,000) in the 2021 WhatsApp lottery and you are expected to claim it as quickly as possible or your lottery will be transferred to the second runner up.

Its a way to appreciate your commitment to WhatsApp and the impression you have given other people about WhatsApp.

For Security reasons your winning number is (WHTZPPX9) please keep this information very confidential to avoid being hunted by hoodlum when you finally claim your winning.

Your Name
Your Address
Age
Your country
Your winning number
Your Telephone numbers

Yours Sincerely,
WhatsApp Admin
