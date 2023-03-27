Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F566C9A8C
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 06:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjC0EdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 00:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0EdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 00:33:23 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216283583
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 21:33:22 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id e12so5382655uaa.3
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679891601;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=js2uJIokhkHeRMu7QEwsCcduvbQaMJj+HKIMXOIls+g=;
        b=qpN6X1Tj4ovRWJS6+Ya+XSLxfPSQAupu9EZGPCt1rzRlE3Z7wUOBEcxT3zr//RI61/
         QxM9l1CwKciEb67nEB79Bm3kibcpnpu8wwiX9P3NlYBUxfN1h1bS4EA2qM7f0chchSu2
         Yhb9Sc39VPjy4RfOl5IVfWgDv1NIF8sSyI8Vhl9lgIkQ43SmFgztEAw39mQZv4dYGfS2
         i0PaA3zlWSDY/wawAZD0GQcqAiXqO29YK4QxKPZlfF00GyypiIha5ooOXy77A2cpT5Aj
         xjfTsAxVlMDw3y0dSx0tSnvfzxbVGvlhBZZ+feqWsWE4WLFjNFhPWkseu1/zjgpzyGVH
         6vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679891601;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=js2uJIokhkHeRMu7QEwsCcduvbQaMJj+HKIMXOIls+g=;
        b=WGRrIkVZ00rDU5s/0Adv6mHQD6CkL/yoG9bldS70PpycpqVlI0KB4hs/L6Sms2hWeI
         IIU0ZTSk70/JSf17s6XE/VjMe38NLNd+3Fm1s4ZS2XROPTIi02O90axV/Y9SN1TNBoVD
         nNKJ0B+3xZfiu2XaLcBv3UIWu6iYyzKaPQN839v++StzVTbfW42Kb5OYhXaJUrzpeAWE
         3vGYPwpztkaDDxkifm90B3L8vlNMDy6n58MqLlKPfbWVb41lXUlrdOC39dkzC+K2adu+
         hEiUnUcohgsEGO2aGIaSskjI0QRglM+p1OImc0NM4KAxcCEdG1WXN4EUuGd1cl95JW1i
         1DCQ==
X-Gm-Message-State: AAQBX9fCDdSq6YwhbFoLFKc9vSDTjEK+N4SOW7S/1G60nRACsYowF7kw
        GQF4VxAJEt2KOgHX/GR2XwwFDr4lmYUfISjTY6w=
X-Google-Smtp-Source: AKy350aBGWtB7Dh5noYcnfcWLxG/PP4M3+CdWw5MadOx7bdJEgLrNoDGDgU9IeMCCcYdd9dRvXIj7FcQtfGJF+eCwTg=
X-Received: by 2002:a1f:3890:0:b0:432:911c:d523 with SMTP id
 f138-20020a1f3890000000b00432911cd523mr5573215vka.1.1679891601141; Sun, 26
 Mar 2023 21:33:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: vandekujohmaria@outlook.com
Sender: czabsonre2@gmail.com
Received: by 2002:ab0:241a:0:b0:751:4d2a:970f with HTTP; Sun, 26 Mar 2023
 21:33:20 -0700 (PDT)
From:   Gerhardus Maria <vandekujohmaria@gmail.com>
Date:   Mon, 27 Mar 2023 04:33:20 +0000
X-Google-Sender-Auth: JrWrB7RgHCMh1rmpNOcUGHs8w8M
Message-ID: <CAAkxaeOkWQDZ43dCO6=11mHxR9TEkCNNEe+3NfJ7b0nwxxry7A@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=DEAR_FRIEND,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:92d listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [czabsonre2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [czabsonre2[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
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
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Dear Friend

Hope all is well with you and your family?I'm van der kuil Johannes
gerhardus Maria. I am a lawyer  from the Netherlands who reside in
Belgium and I am working on the donation file of my client, Mr. Bartos
Pierre Nationality of Belgium. I would like to know if you will accept
my client's donation Mr. Bartos Pierre?

Get back to me soon
