Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264A663924B
	for <lists+bpf@lfdr.de>; Sat, 26 Nov 2022 00:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKYXop (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 18:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYXop (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 18:44:45 -0500
X-Greylist: delayed 480 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Nov 2022 15:44:41 PST
Received: from mail.psssf.go.tz (mail.psssf.go.tz [196.11.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27F59FF0;
        Fri, 25 Nov 2022 15:44:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.psssf.go.tz (Postfix) with ESMTP id AD56C100287A;
        Sat, 26 Nov 2022 02:34:18 +0300 (EAT)
Received: from mail.psssf.go.tz ([127.0.0.1])
        by localhost (mail.psssf.go.tz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id q5f3htDzZxNb; Sat, 26 Nov 2022 02:34:18 +0300 (EAT)
Received: from localhost (localhost [127.0.0.1])
        by mail.psssf.go.tz (Postfix) with ESMTP id 622A910029AF;
        Sat, 26 Nov 2022 02:34:18 +0300 (EAT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.psssf.go.tz 622A910029AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psssf.go.tz;
        s=psssfdkim; t=1669419258;
        bh=GgFYceHPfP/4Ju84fndFJB/TSJ1oqCCcVK78ii2DXwQ=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=Y6V3JSgKw/SfCfol1hr65sSPxBy2qUAnc5A1bbos2Yk8h0crnMlJm+5/fWqbjk+/V
         snJVpaXkApTPFzy61JO7nJPrsDi5dprOVbIKhugMpPJVI2U4SrESRpx+HbZhKPkl5V
         74EBf85GGuD+x32a7Cy5Gp+609nGcYzEQ+XDAomGQgtcyjIxdW889ELNPwNm3jgA1n
         y+0JWCrQ6Gl2YluLHiYSl+RBSop8/VQIyt+HMGQFsY2W9FA1NWgRzCq+lxARBTpwos
         YDoqU5nEQFaGnKt02E8oouPta+VdEMbU+NpIHFljUO5xAPlRUwqFo4vj64xsjCS9Ct
         61y8AkziycBfA==
X-Virus-Scanned: amavisd-new at mail.psssf.go.tz
Received: from mail.psssf.go.tz ([127.0.0.1])
        by localhost (mail.psssf.go.tz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uvjMoxxCtlvX; Sat, 26 Nov 2022 02:34:18 +0300 (EAT)
Received: from EC2AMAZ-O7KPIJ2.ec2.internal (ec2-3-238-242-41.compute-1.amazonaws.com [3.238.242.41])
        by mail.psssf.go.tz (Postfix) with ESMTPSA id 28C1E100309A;
        Sat, 26 Nov 2022 02:34:12 +0300 (EAT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: 
To:     Recipients <lusajo.anderson@psssf.go.tz>
From:   "Rowell" <lusajo.anderson@psssf.go.tz>
Date:   Fri, 25 Nov 2022 18:35:48 -0500
Reply-To: rowellhm0192@gmail.com
Message-Id: <20221125233413.28C1E100309A@mail.psssf.go.tz>
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9891]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [196.11.255.52 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rowellhm0192[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hope you get my mail
