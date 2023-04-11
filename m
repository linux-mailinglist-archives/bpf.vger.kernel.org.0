Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507186DD831
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjDKKpK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjDKKot (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 06:44:49 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044114218
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-504ae0a68e5so984042a12.3
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681209864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfVujZJMblmN4ROxQr7Njq2LGd6WAW8BGXNUP88pRwI=;
        b=XZOXTGi9XvVmNZaC47byfuYlRSD10lOv9LUKbz0DUGJVd6ycaV72DNXI23tbga/nqG
         d+o8li3uf5itxBHAy7xW8E5t+e06lV6YP5/uakqzLAOCyQIo1xSrZWL4RLzOYoge1Ttj
         e68eX8gEwigUwRvAFISeI2L5z/oI84ferLTqHI7TKgkXwvbtL4qEkl3Whw49xfzSTZAW
         SdC1CeqRIy0oQ9T5SuLSSULUlUjO7kaPCVb7HjYn7ic4fjz6KMfhfp59F0XlJIBjz+mv
         uFqWdK/iyuFxwfqR3Y7YJxmydlWzTUKfT2oQT3D78P++DZKb7+lGF6vXQVXtjFb40rSc
         9GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681209864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfVujZJMblmN4ROxQr7Njq2LGd6WAW8BGXNUP88pRwI=;
        b=hmpPVs66KxHEV/OB+JEjms+T/MNDR2zKJrWcs/XURh6e0aRulrs0PoVXn2h3uL26VS
         KR4wc9+XEk/CesGiI3xrFAPzNNo7PN3kvMWqxVdkdeQrriuWTOCZxqTw7LHcfgpSQyWY
         fV15u0azrxXcOWlXVGULCZFq0yYggXIyAFbAngt+BLcNFzNI9OLOf1G7TOZtUwu+2Lvs
         /C7eVlYR0dKA6evZf0xa/+SE72yIwrAAqgeh/A042hMsWOEgCjkpORikwdZNKCyyFqdP
         kG3jiUpDnozZh0i8usr3+ktffGs0VuOtB/u3wsZY+P96teVrZr1eIsqVYBB1vQN60rIU
         CAGA==
X-Gm-Message-State: AAQBX9eb3vy3VZSbUeAmgZU4Hnh/olEH8mRULYCWOmp0gGWBf7BRi7C4
        3pG99G0xnKgj/FETy1bmhr7OsRMMQzMkP3hEmMh8aA==
X-Google-Smtp-Source: AKy350bfQiFCZps0G0+yQUCKsrSHc9DQzSkwxVOLubja3zppoX1T+qspQLahNE4XJDDNbylao1O2EqeXGe1/gXODD9o=
X-Received: by 2002:a50:9fa2:0:b0:504:81d3:48f with SMTP id
 c31-20020a509fa2000000b0050481d3048fmr966647edf.2.1681209864276; Tue, 11 Apr
 2023 03:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230406234205.323208-1-andrii@kernel.org> <20230406234205.323208-13-andrii@kernel.org>
In-Reply-To: <20230406234205.323208-13-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 11 Apr 2023 11:44:13 +0100
Message-ID: <CAN+4W8iGE-dap7FT=SbJ8r3+wn=0LB1forZ1_Ppvm8D0b0QC5w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 12/19] bpf: add log_true_size output field to
 return necessary log buffer size
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

On Fri, Apr 7, 2023 at 12:43=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add output-only log_true_size and btf_log_true_size field to
> BPF_PROG_LOAD and BPF_BTF_LOAD commands, respectively. It will return
> the size of log buffer necessary to fit in all the log contents at
> specified log_level. This is very useful for BPF loader libraries like
> libbpf to be able to size log buffer correctly, but could be used by
> users directly, if necessary, as well.
>
> This patch plumbs all this through the code, taking into account actual
> bpf_attr size provided by user to determine if these new fields are
> expected by users. And if they are, set them from kernel on return.
>
> We refactory btf_parse() function to accommodate this, moving attr and
> uattr handling inside it. The rest is very straightforward code, which
> is split from the logging accounting changes in the previous patch to
> make it simpler to review logic vs UAPI changes.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>
