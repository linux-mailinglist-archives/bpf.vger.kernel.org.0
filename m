Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75396500675
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDNG67 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 02:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDNG66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 02:58:58 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55B53E1A
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 23:56:33 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id w128so1893452vkd.3
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 23:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=aLtfqT5Yih5XAHYb65ktfPkbYEAVynC/biF0hSoHjT04Ba2llFkFNdP5OgM11r1XLO
         P+z/9jBPmRqnp5zB0/IctB7jFe5haYTNxpIe8rDM9BdGGswBTAT6EjqKv0fDhCTY8Vf/
         EfqFIpGs4HjGcOqK0PJSJ8G7Pd5ZzcDzWhjQsIRirhKlJrf9IZBtDP05Z0NnVEJdZoOI
         Ll+7JzbJjFdOaeTuOp+hflqF1GbVK8fFfvS1NjJ3ee4gNFgzdcteqsVmsc/pb760ThUe
         UNdwnYGo8P4ciMNbIkd9idyraYk9j0YThUesByfz0fY81vhTDJFUAvqYnWWACkZ1zL3v
         iyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=WNYXIGq5WNPoqED/3aCUz+IMip4Ym8VoW2dm9KE404MI90djWgR9/67zT3WLsRTHV4
         qLZ3JJPeKNY/xCxGzasyH1EIkdyXUHLherPUKBlm1skGho/X0N5dpLk5rXJDHyUAkWdb
         7Wu0jO6hdSVfdTYk4u5m6V7YodzoVWfJu7SakGJFXS9qKSacS0gBHAejJRvN7saAhiCd
         S8pGjUaPsv3O9eimvPO2xKumXRqSYekigFTngHQgn+Hw/Y3QkV7H1+6DxmgrLW8+sAhw
         HLEKgYUXPh1Z5FR+xhMiD7z7DXv7YZCkqhSV/PaxVebSSuEocsskeOcDRIuy04N/GEIf
         lcOA==
X-Gm-Message-State: AOAM530L8LQ2H7HaEU2UZRbcnXaGawkAHplD20RoZfioCk7G1Q3MKbbe
        liR/HTsFlPuFxUNvdChviBGcQDCWQ5HPw/tQ4wM=
X-Google-Smtp-Source: ABdhPJx9lfeuOlaBSaI7G6h2cnooqkcUCt0vcXZku3DLoprlWqDVbXbvfAw7/BMHMU+j/SyxBGE724X9wqgfAVPkEIw=
X-Received: by 2002:a1f:5c8e:0:b0:348:d8f9:df34 with SMTP id
 q136-20020a1f5c8e000000b00348d8f9df34mr971376vkb.10.1649919392734; Wed, 13
 Apr 2022 23:56:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:b00d:0:0:0:0:0 with HTTP; Wed, 13 Apr 2022 23:56:32
 -0700 (PDT)
Reply-To: daniel.seyba@yahoo.com
From:   Seyba Daniel <kishore.manu21@gmail.com>
Date:   Thu, 14 Apr 2022 08:56:32 +0200
Message-ID: <CAGoscapusPms25Nx90c-XDgQ5fMrsw7jrgbeWR+QKmvx0d3kLw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5537]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kishore.manu21[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kishore.manu21[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a44 listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
