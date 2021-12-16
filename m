Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1938D477569
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 16:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbhLPPJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 10:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhLPPJh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 10:09:37 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B87CC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 07:09:37 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so29272298otv.9
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 07:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=G0RN1/MB2GDdOZ8S+RSntY+TeGIHAxl+ksWenno3NeM=;
        b=ZfjHNejhizhinAxV1rhqwKhSsd1pW6OrUQKT3pZ16ZKePJqz1dmEsrrbx6E0YhWJS7
         SOdaIuqAjnzX56IKaWJlR3dmftyk5r/v/FBcaOtE+MG6lR1V7tegMUU2Epl41tgy5VZU
         Otr8wPLrItew57d4/B+L9+x7v0bFYESCOhf2azILbGsnb0mOcKbSk7NAOUiwjAlIT8/j
         LgAiOmM3Pv31lfjb5bxRk5G/fDQ5YSrMQjqmwhjqpcvV55CO5JEjdkJJCdlnxEV9k/ki
         pRYwjXbxH5tg5AK2NRYtljFMtbx4l766Cca/iDe4f0rRLrWKy8YKpG35LZazI0xe/XtB
         7DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=G0RN1/MB2GDdOZ8S+RSntY+TeGIHAxl+ksWenno3NeM=;
        b=tY3J/Po7rokEJn9V+Ajd+aU6islRGpqw4mB2gtL8GVqMWNSQKcoG5YlnVBMdMQ0KIT
         BKkOb5JxFh1Fuj3fH3o17L/OqQ53sPUPCD+RSdIYHhtacOckULiWzK0rEziWJD9A1h51
         VBVo/u8ym89sXzh/FGIesxHhx6kZsnE8PFcBJ/girPwdOQBDDF1ArLrVilf765IjxQRt
         OUldhraxYR1WQpDlmax811Q1xLZPI2JWZEN7/+ytMCJZ/Q3wjeKpbCrRlPDjhxAT515z
         LhyRSDT59mexGQN6QXaSEQxBWDpLBjqScYhDWOf5GFLiGPOYpUFTypA3q4H0Ucl//LLP
         J4Gg==
X-Gm-Message-State: AOAM530XWznpRT9CEhkwOJb3VEVWBGuFT59ovLsU+xTWOqKT5AnTDuGz
        q7qwroIgo9XzY1TvIIK1cTWqZp3xalhirFHi/P0=
X-Google-Smtp-Source: ABdhPJw8VUMLgDCdErYY8Tb2aD+Iip6y+/OK/x15PpFC59cCUoTDqBjlFIm0M9z5GUOi2taisRan4qQgnCUgj9d2j9Q=
X-Received: by 2002:a9d:734d:: with SMTP id l13mr12706368otk.292.1639667376456;
 Thu, 16 Dec 2021 07:09:36 -0800 (PST)
MIME-Version: 1.0
Sender: charityvangal@gmail.com
Received: by 2002:a4a:d9cb:0:0:0:0:0 with HTTP; Thu, 16 Dec 2021 07:09:35
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Thu, 16 Dec 2021 15:09:35 +0000
X-Google-Sender-Auth: D0WgKHmAELnhqLT-JkMG2XHRPdc
Message-ID: <CABTbXjL8LJdO_SmtwqcxkaaGDqvoct7ZZ4YHsut8n6aqqxtczQ@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello my dear,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs. Dina Howley. Mckenna, a widow. I am
suffering from a long time brain tumor, It has defiled all forms of
medical treatment, and right now I have about a few months to leave,
according to medical experts. The situation has gotten complicated
recently with my inability to hear proper, am communicating with you
with the help of the chief nurse herein the hospital, from all
indication my conditions is really deteriorating and it is quite
obvious that, according to my doctors they have advised me that I may
not live too long, Because this illness has gotten to a very bad
stage. I plead that you will not expose or betray this trust and
confidence that I am about to repose on you for the mutual benefit of
the orphans and the less privilege. I have some funds I inherited from
my late husband, the sum of ($ 11,000,000.00, Eleven Million Dollars).
Having known my condition, I decided to donate this fund to you
believing that you will utilize it the way i am going to instruct
herein. I need you to assist me and reclaim this money and use it for
Charity works therein your country  for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of God
and the effort that the house of God is maintained. I do not want a
situation where this money will be used in an ungodly manner. That's
why I'm taking this decision. I'm not afraid of death, so I know where
I'm going. I accept this decision because I do not have any child who
will inherit this money after I die.. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account.. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.

I'm waiting for your immediate reply.

May God Bless you,
Mrs. Dina Howley. Mckenna.
