Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913720282E
	for <lists+bpf@lfdr.de>; Sun, 21 Jun 2020 05:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgFUDgD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 23:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgFUDgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Jun 2020 23:36:03 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F92C061794
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:36:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id e11so12972333ilr.4
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2020 20:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=x80QWUij0zy81RzQKz9MNH4WbIjG/i0y2UQtn7XTC3I=;
        b=W7KgypT7LVSnW+Ts2pvosqXOPJvPwNTw7yaMIXXsz5W8tKkz8txlAsX2i8bOAV0epn
         IJHJeTeLqcrR8meUZquwgOjP2B6IiqwglxSpQ8k6WIwZ8yyUSLAQOXCnGfUHlGknICgF
         i1p6nWXMcbZEERByM1ZsyfuE6jjaz8uQuxgElLJR6ELECjNUYpzopvZtXjIt0jRes2OO
         PoctTf1O5Rxbhxw3wLa0G9zd4eo6wE/eArzqr6nFckARoeT1isLCtwpkY6vTlj34mNCC
         9Hxy72Lie7LRI9Q1QgeFmCZRhTdRt7aobvursH/+oK1HJ6gZ1swxJx/RzzsxIKxkqrOU
         oR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=x80QWUij0zy81RzQKz9MNH4WbIjG/i0y2UQtn7XTC3I=;
        b=nMP8vzVVZ3oz4BBDJe2/sRaXNlWCsl9WqWcfo0a7G67kl0v2IirGfloGQO/DeIZXE9
         llOwticnkUTTNDT8ZlADgdNcrdDvIF1sJkFrcjV0UnIYB5b9r5i4s7zS6YKo1Zr2lxmZ
         B4a8UIDWh58uYM3eMsFINEG8tB1STE045Kg3WgwKSwb2ztWpu0AjUS0ibGzPVW1ieoZW
         p8XzALpfpB5sMqocBY1+DfEgKbga50eTzN41LvqpTT5ZYw6BIcqNET/bjACY6zMStUJb
         3Kr6yI8uoDqFoB0FOEWpdpkqUK/gDf0pmCD14dmFyrt0erm1sN827qSUFFPV3mo4bZQe
         bl8g==
X-Gm-Message-State: AOAM5330tugHjN2uPkuP6Ad2Z/fidfKt78m0MW1uOb/WRnp7DX6BcPNs
        OkS/S3/w5jUL1ERkATdTLvo=
X-Google-Smtp-Source: ABdhPJwyEr6pneEtuVPiMboYsTM/Vbz+IFZIgzDWNzWtGBdFaKns3M1ixp/+zXh+v2YDFJPXLG784A==
X-Received: by 2002:a05:6e02:13f2:: with SMTP id w18mr11192548ilj.265.1592710563006;
        Sat, 20 Jun 2020 20:36:03 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id l9sm5684999ili.86.2020.06.20.20.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 20:36:02 -0700 (PDT)
Date:   Sat, 20 Jun 2020 20:35:55 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>, bpf@vger.kernel.org
Cc:     Andrey Ignatov <rdna@fb.com>, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, andriin@fb.com, kernel-team@fb.com
Message-ID: <5eeed59be913_38742acbd4fa45b893@john-XPS-13-9370.notmuch>
In-Reply-To: <139a6a17f8016491e39347849b951525335c6eb4.1592600985.git.rdna@fb.com>
References: <cover.1592600985.git.rdna@fb.com>
 <139a6a17f8016491e39347849b951525335c6eb4.1592600985.git.rdna@fb.com>
Subject: RE: [PATCH v2 bpf-next 5/5] selftests/bpf: Test access to bpf map
 pointer
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrey Ignatov wrote:
> Add selftests to test access to map pointers from bpf program for all
> map types except struct_ops (that one would need additional work).
> 
> verifier test focuses mostly on scenarios that must be rejected.
> 
> prog_tests test focuses on accessing multiple fields both scalar and a
> nested struct from bpf program and verifies that those fields have
> expected values.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
