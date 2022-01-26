Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D983349C38A
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 07:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbiAZGSN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 01:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiAZGSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 01:18:13 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC0C06161C
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 22:18:13 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z4so5892068lft.3
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 22:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=Ugxbjs9isEdHaKiWsD+YT+GJT/xtgTjUV7oTWl6VKbIIwjhYhUtU2sPHaKhp09+j8I
         z3sMPeTFDfUhYfHqRyEkGpNe4XrxMNExW0/Bmd0yV39SN6sSoi2Zwq6znjrTmpitK0RM
         GqTU0ttrRYrWFoXIxNorajb5qGGHnAzSrhfIJHEcbPe8Me5nB3yY9tIh5CeVyqWqUQYq
         BW5ivow4dR5TsIicRzBrihLBPyU+0zwsdUWPj17ydP6jiOMgDUnq+V9bojCWoyWAy940
         soAfZhuu0XCHWLI1RuZMEeltgCSDOrgYicEx3T/94dCcbZfPRg0i9YSUBtJXeQQnP0aK
         LOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=S5sdFu0RQlZFvupo/qwNdlJ2GO8zZANN1PS6veJLDy8=;
        b=GDNtJ+SZw8xLLkEAkRwHR9QsbETmu4xis7UsbMcGwTMKgVJgUvZ26hXQO6sAMXdLT8
         Jt9bAkTTlBXCioQJwXzDkWqINVEXyt1mz2LBAZ6Zp1XJONKJshMyDwBSSxLvk87rbFzF
         2Ql60krTYsgyjp0pwC8Xa4EheOLumIuZ5oX1F3fn9IJTXPSFVHQp3O922ryaGyCzjbOc
         p22woL6Kc3KMWdedzpj/aMlZPUZc4PJUgXdM4DoFP+/XOMlLPVpWJ5cyLt19DS4i2kct
         qIgj/IV1i/mdTeZnwi71j/0/CGRWAGu6ijKZ/7FHRC0eIGQjETD0vERbMwflQPup0i1R
         +c1w==
X-Gm-Message-State: AOAM533T2rDvu5LMe64VRklGoyOWLEFrFMBOOiymFaNa0hS/JNoG9KwD
        l8yiBhLNhb6IZiPcNupBfs6EQtqwKblCZ8moaEA=
X-Google-Smtp-Source: ABdhPJz84yT+CA2Gfpbr0P0OLXoHemUn5I8r85hXUqCc4OtX1QnCuRkbg5tHQ2cm1/dBskDXDaNM3TAtfNG8pFhSTcc=
X-Received: by 2002:ac2:5978:: with SMTP id h24mr11859341lfp.584.1643177891026;
 Tue, 25 Jan 2022 22:18:11 -0800 (PST)
MIME-Version: 1.0
Reply-To: kl621816@gmail.com
Sender: hippolytepilabre@gmail.com
Received: by 2002:ab3:6a44:0:0:0:0:0 with HTTP; Tue, 25 Jan 2022 22:18:10
 -0800 (PST)
From:   "Mr Ali Musa." <fl621816@gmail.com>
Date:   Tue, 25 Jan 2022 18:18:10 -1200
X-Google-Sender-Auth: pendZuuvr91cD7TVI6EiJo9WkKg
Message-ID: <CAK8dbAXyMbCGFQTAXrrUhfee1MYzwNxcq5frPkAN_A_Ui15M8w@mail.gmail.com>
Subject: INTRODUCTION:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Friend,

 How are you today, Please accept my sincere apologies if my email
does not meet your business or personal ethics, I really like to have
a good relationship with you, and I have a special reason why I
decided to contact you because of the urgency of my situation here.I
came across your e-mail contact prior to a private search while in
need of your assistance.

INTRODUCTION: Am Mr Ali Musa a Banker and in one way or the other was
hoping you will cooperate with me as a partner in a project of
transferring an abandoned fund of a late customer of the bank worth of

$18,000,000 (Eighteen Million Dollars US).

This will be disbursed or shared between the both of us in these
percentages, 55% for me and 45% for you. Contact me immediately if
that is alright with you so that we can enter in agreement before we
start

processing for the transfer of the funds. If you are satisfied with
this proposal, please provide the below details for the Mutual
Confidentiality Agreement:

1. Full Name and Address

2. Occupation and Country of Origin

3. Telephone Number

4. A scan copy of your identification

I wait for your response so that we can commence on this transaction
as soon as possible.

Regards,
Mr Ali Musa.
