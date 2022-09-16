Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822385BA3B6
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 03:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIPBK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIPBKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 21:10:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16334D256
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 18:10:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w22-20020a056830061600b006546deda3f9so13794027oti.4
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 18:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=6nehn4SZ+N5DitBflpC+8AB9tkDm5FI3qla1CH9afZQ=;
        b=np4RaCUtWX8kie5xR3+NYRsf86Lvh7VeIAMxOuIq718CXvBEpzkcQxvmj9NFJbbq6S
         rB/KC14woUsMii5QWF8gKo11UarH7mCNVB+g4RJwC535+AKQow90KfkgMhuaMWXgbP11
         DgDbOqunTyDTmVVwvrVuZEPV6eVd3I+2j657yHv3/HRNvKL9Pn8d4NjU5G0YxDKpCZ7i
         dOoR26svVf91E2XQHe55THbDma6dsOKMZ+B3IzFmpZrO077svkYkBTCsQq9RlI2IaExA
         RxixVRRIMS+s/o1vUzPVc3r+BqjLTesNL+87vTP6SaKdWJe3/zbEiv8G6UT05U3iFOht
         +9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6nehn4SZ+N5DitBflpC+8AB9tkDm5FI3qla1CH9afZQ=;
        b=7iLNgWpP02tWTsO2iXme8FPWvhAtBnDl0LwJN8aqpizJc3arBZUzMMl8OAdofDCosw
         j5EXiAot63kOtkDeOyFV4DNeqwfrBOUiFjeJruJvqgw44btsrD2LtD9+LfSP1OSj0OG/
         W3WRrKrfWqO4ycb9nq4aaYQp1ByyPVZhQ3a4K9rcto3vg0Wzt0bY7yugI8hSPLT067iZ
         P4VlnnirWFhVAvH12nct9xVPypHAZk5QJHMxUMi53p9CsR3Q8XVE0cH0OfFDj39B5i9Q
         HfIIjz3QdzZ31DCxpl9qDoWerrm5cvv74DZpo7cEQJuB2cVgaOyel0ERU3St2CRzJKXN
         uTJA==
X-Gm-Message-State: ACrzQf0jGdkbaqeF76bN9HCbvl1bqL6/yLYDSitqppby74tgaG4BCRip
        DnLz+yY+ZBcT/hxDkg+ZfHU1PhfZmvVxc5oVvQ==
X-Google-Smtp-Source: AMsMyM6Ip9eJ7x168CMGYhYckHP8WIm7hEZDQ0vUIDP7Xb5FYoinF0pKq2hsipyTSj1ypuXP/4z64t1g9QETj1D31sc=
X-Received: by 2002:a9d:75d8:0:b0:658:fff4:371a with SMTP id
 c24-20020a9d75d8000000b00658fff4371amr1186676otl.314.1663290620391; Thu, 15
 Sep 2022 18:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d001:0:0:0:0:0 with HTTP; Thu, 15 Sep 2022 18:10:19
 -0700 (PDT)
Reply-To: un.loan@unpayloan.com
From:   Tracy Vornan <graceali1977@gmail.com>
Date:   Thu, 15 Sep 2022 18:10:19 -0700
Message-ID: <CAFbUGG8L+5-JUQFZqozCNRsazdebrJoCYaWtFMUsLpK3uABzGQ@mail.gmail.com>
Subject: Apply for Loan
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

-- 
The United Nations in partnership with various financial bodies is
giving out loan grants to help qualified individuals and organizations
reimburse their businesses. This offer is available to everyone across
the globe and is targeted at helping economies that has been downed by
the pandemic.
