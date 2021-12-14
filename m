Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9305747465C
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 16:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLNPXr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 10:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhLNPXr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 10:23:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC67C061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 07:23:46 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so63380214edb.8
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=XrZGipnCNcQSBb/bCOcdEult9uSJSFeSx7hr+bZ/cJUXsYSk5z+Ep+DSoyLLEMa8l7
         KTfXxUOl0mdUY1BZOBQqA5VEhI6CwK13dkGR2XxdfWJ0Mpy+IXIF0cABsYj/xJR8tm5E
         1fIWHJBGYc60MpoQVKfuJ+pwMr5pcJa/xKhhKYE9VKwL2UbEsSXPfpFJcsVKwW8kTePp
         n8EB7RKqvCvk0flEpqZn2QUv4+X1fkuaIwL2yU5mpL1UWNSZ936dwh3rk3brEsCuX0ML
         ho+njLztN1lz+uS9gek/00fYOxWde3938x/yjnEIqoNGvn2AaWXo23X1BbAd66YFgP2b
         V8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=Hp2wuf+GFIgPk2krY9oLPCwUDqecUtCiJ9IkJj6FAwY=;
        b=EyQSyK/7Sj+3uYmODqLm18Qf0xsJDr7w5UpQo4LqKyMvEDDn19OYkPQ6vXh29Oz8wX
         JBshDURORdI2md3ZLqyBpopTF3Hn39pNYFJ7PiPMaDlvH0wRoROaQV2oPNS2eLPMjBqp
         km/sysy6qgoMyPSuZfTzTJh8+jtb+NovWvQfhfu2KwHfWALx5UPQtTskvT6/zjvop2ft
         y/6nR8EqIukP8J8oz9zoMYgpBBun1SRJtnLyiF7gLpXIuWgGf60HQ+2ShMKILLapaf+g
         gXSP2AI2PLQHpY2YSW4J2oAnR/l4Pd8KC94H00BB1sCIAnqvgHlQGovX2i3KBjNdp0j0
         oDpg==
X-Gm-Message-State: AOAM531neFvCue3FKOGqGMz1cGm/1UMdfp5Qj/Sk5wfA/DogmMdggIxn
        k8AFG6DQh6dcufZOdl3khjnzcm642icvxM2gbKw=
X-Google-Smtp-Source: ABdhPJxG7q2WKxhwdkCHhNoM6unxMHB/hOFsD3JQ9GqQwNgmy6POwHswoG1XtD0VBhVSlHXIZfdQasFFgYxtcL3eY+g=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr8641262edb.89.1639495425414;
 Tue, 14 Dec 2021 07:23:45 -0800 (PST)
MIME-Version: 1.0
Sender: patriciajohnvan@gmail.com
Received: by 2002:a17:906:99c3:0:0:0:0 with HTTP; Tue, 14 Dec 2021 07:23:44
 -0800 (PST)
From:   DINA MCKENNA <dinamckennahowley@gmail.com>
Date:   Tue, 14 Dec 2021 15:23:44 +0000
X-Google-Sender-Auth: 5Q4LfrIHxG5IMLoT57mCxX7UotY
Message-ID: <CAHqodhShzyZW-8qYRUPn5vsWZ1bD8wZR3aGYJrkODBg9NuZ4Pw@mail.gmail.com>
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
and glory upon my life. I am Mrs. Dina Howley Mckenna, a widow. I am
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

I'm waiting for your immediate reply..

May God Bless you,
Mrs. Dina Howley Mckenna.
