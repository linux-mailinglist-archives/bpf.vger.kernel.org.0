Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0FA452906
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 05:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242867AbhKPERl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 23:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbhKPERg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 23:17:36 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE451C1FE13C
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 17:07:30 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id t13so38824294uad.9
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 17:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0v9/w1kwlZe3Y9CHxIJ95jhpL8Uq6xy89EP65EB4GHE=;
        b=ALaZ4vVRfcHQAkTsI8ASUsFGHmwLOMJSuIiIsJ45eUKW/brbgm7GRmyaQ1HIhVozZk
         zAxVem/ZO7o33RA/vO6xVyC93QFSOpRsCLQq6kSnzx9hiickXKnvDZ04Z5oUnQSRla1B
         VPZ0l60pIr9fVtpCbjZVM+6qLB1Da/Yp239wOeDH+/PreWgHTDYVpKBs20/sc1y9azeC
         n66Rj67mzQEJ8SlkA+4rtuW5nsG6AGUJz+EJQiamncBPHNc2s0cszkA8zY8CcldrlLs2
         Lcbrfty/yg7cZnoZtoTlmyPQ8kFSHhMzdbS0BWsUfFrZtScf380oXtd6qqs3mOC42pUH
         MjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v9/w1kwlZe3Y9CHxIJ95jhpL8Uq6xy89EP65EB4GHE=;
        b=cBPxhdiVHoxeiINByznabNyifhU7yFjykDBFxKHi8yN0OEKLAZSiguBR9pmGXWgXIw
         70NAZweUc1cB2XUZspNPQpREKvszSfZ79X4LDTvtaM9IJqroq0/iir6k5dr8OgyAG78p
         yy1l0WsHGMVgXAT9+mmjy+Lgq8+vyeu2Gf0gzo/jiWsI4gcIkAO90iXUtECPklj5i5Rz
         cFjfSSl7VzKfTuh/iP07RvFHxHMp+YM51NG6aNNWSFVS9423cmrSgGW56K2RgE/lBw88
         qiGB5gmrRgw9r3adaq8iDMKHl5kRXMLauzIL5KnyRv2LRFjHazijE9V6nzXe0tAbYtJS
         VeEQ==
X-Gm-Message-State: AOAM531jaNVn7lqXnBr3/Tc6HMPG5TSzkQwdymdWUcU/goyz4B8pyGqS
        m8X2IQmESjHf/93C5Osos8i89LEM/JBSxvxioabiZQ==
X-Google-Smtp-Source: ABdhPJzbcWmlRLdA6MIM0qLD1PKwDmCChyk0clrDxyXB80Eevf0CCpdAoYHBlF/79xHquhLQCeGojNnkcd5GgJc5A7Q=
X-Received: by 2002:a05:6102:d8d:: with SMTP id d13mr49477683vst.54.1637024849982;
 Mon, 15 Nov 2021 17:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20211116000448.2918854-1-sdf@google.com>
In-Reply-To: <20211116000448.2918854-1-sdf@google.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 16 Nov 2021 01:07:18 +0000
Message-ID: <CACdoK4L-72V1wWDBZPyLMhqUE0NVj+9BEq74Kwq+PZ6q4cGg5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpftool: add current libbpf_strict mode to
 version output
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Nov 2021 at 00:04, Stanislav Fomichev <sdf@google.com> wrote:
>
> + bpftool --legacy --version
> bpftool v5.15.0
> features: libbfd, skeletons
> + bpftool --version
> bpftool v5.15.0
> features: libbfd, libbpf_strict, skeletons

[...]

> v3:
> - preserve proper exit status (Quentin Monnet)
>
> v2:
> - fixes for -h and -V (Quentin Monnet)
>
> Suggested-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Looks all good, thanks a lot!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
