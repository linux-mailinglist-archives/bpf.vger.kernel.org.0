Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89AF6B5D51
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 16:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCKPZo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 10:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCKPZm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 10:25:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E45C1C0E
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 07:25:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id er25so4107540edb.5
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678548340;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qj8nrG0sL8loOIOhZdmt6f4M2skgayD9pumOqV207G8=;
        b=RnaeuorGCGeD0RwEl8m2NuLgxwxAnOik9gHs11fcqc8kny4M4r//vqA8hTBsLrHAZf
         sakGm/qNR8me8vv5K8Nu3+X4GqFJRTtZoUe7G2t6HWR3TZgErfG/CTUujQlH5d2cfBGi
         mSLyzqK7fxiUic+lw36C4m0FKFjQsQsc/RzbwB1kbGv2uwD1PEcySFSjO5512wjEh0VJ
         CWrY/1v0Cnhpay2Jdo1R3Dn6VyeJ2udm3vVcwXRxd03T3Wp1ughkkLeTUcP2dDs3R6ZC
         D5zA4LidXekf6Pl2hyPGYqXRNZPs/0Idt+4PIqzTrP0qXcHYz/6GAR7b8iY7UTM09KAM
         7kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678548340;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj8nrG0sL8loOIOhZdmt6f4M2skgayD9pumOqV207G8=;
        b=Wl9i6dVX+dVDNScg4cgjD/g9KmQ2Jtmwr4GGUjLjPAx7EnolhRlpDdgIiFx+mVcOG9
         uUUDMsr9FsUfX6vC/Qg//N85GRgPuUCrVB5YQBnBzuwlXUUr+mr4HrK8MGkGfF+eitYJ
         mdBkUYUwg31G76uzZiH/mPmPxKJY4aIN7loEkMP6geBKzK4bxYVW8Z9W8BScOTAKo1e4
         cHVxHhPltE5Sb0C/42oS+9UiSgsBeNd9IG5gsn1Uodue+QENstwYyzKBKc9BWNedz/F3
         k3wwXbb182FYrPmaPOlqUkhsUgyYlosmKC6R6bDwS/3EEZ7mfWTNSJqaVCWF8oRg1dAu
         wZ9Q==
X-Gm-Message-State: AO0yUKW1anAjLPhdylbxN8z02GAwDQaGC6sHTHvtk0bQ1o7F84T/oz5p
        vNv+hKbOfw6SwJ5GqFJnMielHTSR9C10zLkARc0=
X-Google-Smtp-Source: AK7set9BNkqEBE3SdEJMH1G1h7g2R7IGS1VfeJLmc0YnKHcTcYx8BRgTp0utRVgwfz09iUGyB6HV7s34omJ9Tk1NAKk=
X-Received: by 2002:a17:906:948a:b0:922:1fa2:af53 with SMTP id
 t10-20020a170906948a00b009221fa2af53mr575855ejx.14.1678548339751; Sat, 11 Mar
 2023 07:25:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:640c:2a06:b0:1b9:747b:f1ba with HTTP; Sat, 11 Mar 2023
 07:25:39 -0800 (PST)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <sd05091959@gmail.com>
Date:   Sat, 11 Mar 2023 16:25:39 +0100
Message-ID: <CABheKPaok-8drjgU1cN5-WnhsDxnDaspiErfF+Ng8W_3ayd7UQ@mail.gmail.com>
Subject: VERY IMPORTANT PLEASE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5132]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sd05091959[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sd05091959[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please are you capable for investment in your country. i
need serious investment project with good background, kindly connect
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response yours
Amos
