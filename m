Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8C36D0C68
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjC3RMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjC3RMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:12:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1C7CDF6
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b20so79277684edd.1
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680196359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtiMW5j7zN1T4ZQvu8tmpfv7fn/hBmGvUpkSYW00puU=;
        b=Ry+g0yIQgtv1L3/aBwxTC8yT32HTcKwvY9SwwvJhoo43mNgC0PShA87hZG+Cr8diKd
         dSesamyedZPDjUuzcqX8AoHtqXDRWYoYvfr/NhBIYZbWEE8QbRfJESFs8cW1iLzvuxmV
         96gWwqJ+/fbKl8aMFYPNrYC/a3d4hj4prHubdGStrAGyGVJYiwOB2d+RPLgB+bDJVVi+
         rxyBLfMtMlB2v9p1I1uAIYtNmrQKr+CcROq2vbR18ypDuaxClI1mjCbHKX9CtRIDDL9e
         fhxuSco1V87DXt3NlFbs/644K2qY7R/5IsjqxYTc4c5Y2JYrOGInDg17PPrist4Dsxcg
         4lWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtiMW5j7zN1T4ZQvu8tmpfv7fn/hBmGvUpkSYW00puU=;
        b=Ms/v+8RxgsLfRIaHvCH5ALeipkgyyrVWN3LtdkJSrGuvd+3ZQC3qXg4RMsnCD1qhI1
         IPvkloCWfIx4rzUWTtuPg0E6FRZFyH9PAbwTJe9EKAhvuvyyVMhMJ91GNGocfkVjMzuO
         yHiIWs/+wLWbykPXp12JY50+iKO2mB10S6Bn1lBjVGz86cvkZ5nRbFl7ItlJ6qI64Pd4
         qlZAauTelc38od6o8NqdgDbVmDXVaOfmVCfyBTOPTyBdctX/Cp57su2y0vI9bS+20J6M
         4xkuauKLTEjUj6/bu2xVU1hLfgapfRxg+HhlwNVh1JiGiETe4bJGkdW8OlFq61kFj7IH
         E/cA==
X-Gm-Message-State: AAQBX9dNQdjqvQrdPqHW20zQtZTp1aiXGNotR57AMSxTVnVL65giW+EY
        8l5is1ZhDDSkKhUnAyENv63DKA/4t4aAzybsE/EtAQ==
X-Google-Smtp-Source: AKy350bOb5O7FQLNHiIRUSXcWYEvRQwkuu3l3YVW2woBSCGfV8/EaFIwbYXNx8hVkmKPBA9QAXyPeOGWcFWq/oEtXhk=
X-Received: by 2002:a17:907:2101:b0:931:2196:b863 with SMTP id
 qn1-20020a170907210100b009312196b863mr10804572ejb.14.1680196358814; Thu, 30
 Mar 2023 10:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-2-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-2-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 18:12:27 +0100
Message-ID: <CAN+4W8hj0v8tQUzhsKzeU51WxdOjPZkry7bbKbc53ECwSowSwg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/6] bpf: split off basic BPF verifier log
 into separate file
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> kernel/bpf/verifier.c file is large and growing larger all the time. So
> it's good to start splitting off more or less self-contained parts into
> separate files to keep source code size (somewhat) somewhat under
> control.
>
> This patch is a one step in this direction, moving some of BPF verifier l=
og
> routines into a separate kernel/bpf/log.c. Right now it's most low-level
> and isolated routines to append data to log, reset log to previous
> position, etc. Eventually we could probably move verifier state
> printing logic here as well, but this patch doesn't attempt to do that
> yet.
>
> Subsequent patches will add more logic to verifier log management, so
> having basics in a separate file will make sure verifier.c doesn't grow
> more with new changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
