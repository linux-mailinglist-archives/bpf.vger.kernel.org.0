Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F64564203
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiGBSLZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 14:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBSLZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 14:11:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3686545
        for <bpf@vger.kernel.org>; Sat,  2 Jul 2022 11:11:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k9so5366962pfg.5
        for <bpf@vger.kernel.org>; Sat, 02 Jul 2022 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Ice2T+QuVPV32HVpdF4TI3vMlXn+101tSMCKRGpOMFk=;
        b=DYbfoNu79H2lb7kGvzHmcMSUfwxyomR2KkX5FHqVrwtLjeqcFuKdD7bhxF6BjLrlFZ
         aV2gtHcybE26kGZOymw7txEThyIpT/NeBesPLk2MJwMM1gCZfNIf8sPwQKm2N9Fs+8+r
         +ijvC3MGfeuMhHdu0MdQlsl5V6SpTUe+ZSHYdapd7hjCS/2Lk2i2ll76QhgabjMvSbeI
         YQfBiYwYn+G0DJqVaTnNZIMv1xDsXVnLAbDJ6MqM4NAanxN0WiLgtuEiDZaJnwnYJ2b8
         NtEyJNFbcKoBqyrYufcabhCMZXZLd4otQMJdHo1wi0U3S2VYnjRXM++axbI0p3eIgFOl
         MgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Ice2T+QuVPV32HVpdF4TI3vMlXn+101tSMCKRGpOMFk=;
        b=oruftA1X9VgFLcXoEMQvK6fadlqpogGRYndsY+LZxtjPK4YPRodmYlSBFQeYKnVrZx
         DmJUohEONJq4Ghsyn+exj8GVYiDdQTk6PV1OSh+p0k4sQ6+1GimBo7hkHEduCqf19yxM
         rxVrp1ecdQgkTcooFMd5HtC9JRE4KK8t5JqAcEIQZh+LE7nURCQlo0eKIwdPz4cUtLT+
         Cm0xCji69+I0P2tBqDpRuvysqlq/Z0uneP2dUmwBXIZX69vpSWykEzfpVCLwvNpmi19G
         If5YTo80YDeI4v8ULLUUAA0OG9Zy9JoAjLuU6eU9XhD49++TVTMpH+yFcc5sP6aiuAAZ
         KdHA==
X-Gm-Message-State: AJIora+nbTsckhnYolDKtwAcj5SfcGc/ETLzasIBK6kHs+QSvMWy1dvM
        0huJuCSdvlfEbFdeIrha9fW8Xry0qutWhEGW2ac=
X-Google-Smtp-Source: AGRyM1vmdGRWaddYEjaYkkfD0SqUKOBaAL0HqZDnCHbTEyVhM1HFrzB1wVTeB4Rm94kw803GgLs/8+ido+PS2EpKvh4=
X-Received: by 2002:a63:745b:0:b0:40c:cabe:961b with SMTP id
 e27-20020a63745b000000b0040ccabe961bmr18261772pgn.117.1656785483757; Sat, 02
 Jul 2022 11:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:7b9e:b0:69:78bc:a99b with HTTP; Sat, 2 Jul 2022
 11:11:23 -0700 (PDT)
Reply-To: keenjr73@gmail.com
From:   "keen J. Richardson" <chiboy062@gmail.com>
Date:   Sat, 2 Jul 2022 18:11:23 +0000
Message-ID: <CACA_eyPV06xiVrJjBwT7iXRWcMR6kpzQqTgnUHceQ6+ENn_-eQ@mail.gmail.com>
Subject: Good Day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
keen J. Richardson
