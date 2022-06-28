Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7503A55D173
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 15:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344904AbiF1Ke1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 06:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiF1Ke0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 06:34:26 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3982231399
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 03:34:26 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id z7so16870681edm.13
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ph19z67WWj8MKbdbfJ/X9NXE3OtaIRjlRTh0jWTZhVY=;
        b=jK92y2NiWevuaeNqcBrSEG8/OowSOW1Qvlr3Pg6bGkjGyDSLcCEI+qpw8iXS/duqV9
         ea0PKyMMqD66VwasMNspDwrUpVS2mIo3PiT3yDac40hCHwdX34QlIQJaThQb5NT9So2E
         J8j9kSq9abU22DpL0wbsf0fW5wfWG4AqVaXQ8x8cgFhUlNCU4cspw563fmyMpCu+CKma
         dT5GfuqMmeCSB6zs0EsmBWotz7Z1DDxafc8OJJoEoYcV34AGXFapHfaRTa2DnOURCoz6
         6MxZB0+gsDO3hLj2GGWeh4YWCttSBdEO4HUJcREynScUBCQlQhUI8bM86AdqcPRCcKyi
         WcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ph19z67WWj8MKbdbfJ/X9NXE3OtaIRjlRTh0jWTZhVY=;
        b=HCW43cc5YX5yMgJIoPFsgKt6oX3gHZCFUP+UFUj0o+R8sj+srsG4vzTDiRddjVV2sU
         BzKr4BIW9KC2hnN+RRTK1CTNW4nSnrVyyHZZ57x5mzyMKIwtkf70lshveQLR5gw5RZFA
         YA6MIMo/jWV7LOp17MgPtAs8G5lMH7m5n/bgtnvxeOqg+6X5YHFYCSgR70zdT4BifipZ
         ahfsVkqQu13/pS2mW45FMFJoXHUKhJvdzZLTJOLG+4tehjlguyacEJ27Ni+NjfiQoDRT
         ssWirAn5748pqwJfEBDJSYZEdXY/1sRvsNq+Gei8cpTdKC/nbB+3T/9PhN+DCJ5obn7c
         ZSAw==
X-Gm-Message-State: AJIora+7T1jAInBiQAwIT88JkDy1pfo+sPPVHuP41giwpkH4+UFWGW2X
        +rbJy7tb366EnGtgHMtQsgp/gL0QiICCaEG35IE=
X-Google-Smtp-Source: AGRyM1v/ECDLnP+koK8MfzSGYxSkZGi99jHx80FwcJyKvO0KVO4sXv6wNRRmibDBhC5+gtkVi51LZy7kEeRt/G9VBOM=
X-Received: by 2002:a05:6402:e0c:b0:435:25cd:6088 with SMTP id
 h12-20020a0564020e0c00b0043525cd6088mr22147428edh.60.1656412464683; Tue, 28
 Jun 2022 03:34:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:250b:0:0:0:0:0 with HTTP; Tue, 28 Jun 2022 03:34:24
 -0700 (PDT)
Reply-To: josephkavin0111@gmail.com
From:   Joseph Kavin <eliaseklu@gmail.com>
Date:   Tue, 28 Jun 2022 04:34:24 -0600
Message-ID: <CAKs0ksBMLvto6ZNtjeayhqLQ3LwKbr_ZwXQ0OiSywKOS5LiYQQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,BODY_SINGLE_WORD,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi   are you available to  speak now

Thanks
