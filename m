Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377F1D0BBA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 11:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfJIJsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 05:48:25 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:34549 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIJsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 05:48:25 -0400
Received: by mail-lj1-f170.google.com with SMTP id j19so1840559lja.1
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=et8lOmtaNN/+qJZCcz6g4EDV9tX/YzrQGsIk14KQrPU=;
        b=c5B0BqgmCVFPWSuz8Da4ZWwxSE8ws4eTD0U/yS6BHkhGBk/XCVcpNFluH4SW+HkM8z
         0SlFaBzp0UCSkdwdaRC2nSAf718vaGc5s2SXlF5P8IkLFwQTboWWJzye9jB1FMSto6zg
         LOqPWNLdTLGJ088fRBr2SmZVEKCwshfJIVh4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=et8lOmtaNN/+qJZCcz6g4EDV9tX/YzrQGsIk14KQrPU=;
        b=kSJTZMuGs+0oVD/+7BkfgjAIIAiKCV2NM+u8gTIqAlcXXcQ/66oLRa4oJAcQDK5Nt9
         sR0IcrvtohQ6aDIsRVKax19D1WpG0z7kITDG4KN2o1iFYcXghJmTgMD7OzmMlaydhCRf
         HOZ2FDbJi5cvfLk68CzxlQ7VfKF3eaWpMfGcpnJrxnqIVfVAGMJa0p5dEgXhrrL2PO5w
         lXKjhKTSPwuiND8ye/lold3gWMfDRaINZPpwbKc7Hqy6gywMMfXKMYqj+Hd3gdGxfhYp
         GwcLF0y/Vrj6xb3MGW+yaUUbKF8J8Vm2zP6kk3AN845gB5kX6KrN4axBzoTjLsEuD198
         Bj6Q==
X-Gm-Message-State: APjAAAXWvYBCOFfJWosrNYuSVsZD1GtvZp1UYE5SN4Nxz6aXOxqoCtKQ
        SmqlMWFyOpaf34eoi4HUA1wBSn23ko+hmg==
X-Google-Smtp-Source: APXvYqwBkW4Q37wwb1SGFBM0wUnR+L3iv3ig723jgRwMG9+jK2+YkkUND15zVv/X4P1MK3txBNOHmQ==
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr1648215ljc.164.1570614501502;
        Wed, 09 Oct 2019 02:48:21 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i21sm342020lfl.44.2019.10.09.02.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:48:21 -0700 (PDT)
References: <20191009094312.15284-1-jakub@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATH bpf-next 1/2] flow_dissector: Allow updating the flow dissector program atomically
In-reply-to: <20191009094312.15284-1-jakub@cloudflare.com>
Date:   Wed, 09 Oct 2019 11:48:20 +0200
Message-ID: <87muea1c7v.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Subject should say 'PATCH bpf-next', naturally. Sorry for the typo.

-Jakub
