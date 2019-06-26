Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85FD35736E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2019 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFZVQS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jun 2019 17:16:18 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41407 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVQS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jun 2019 17:16:18 -0400
Received: by mail-qt1-f169.google.com with SMTP id d17so161583qtj.8;
        Wed, 26 Jun 2019 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4ZRMYDD6VXYHJ3yMoR9yk/ycrqO0+R7vuu/Js8ejT6o=;
        b=bJQiVPJfaBNatgfnUw2XBVrpAdFC6MjIm0gbTy2KAEKrru7C2oC48pdBWgg9nExLb/
         7qLhF/204uVK2JCY4Fd5bMaikbxLNaXl7fkTuDmsxL6r66Igx9fGORB5m+6q09u+CSBz
         VB5bPHLNjsLlqIObmx3Lry+fM2Y6/ahifqXepf8/oLGLYiMc1WCy0lCszmjToc/C4GJY
         KQPVksHOmGYmXbNMoCy7yzYkCUEt3eyZYPsfuasQ8QaJr3KtfCor66AjT6KJF4XUsofh
         r5luqweMaeJVYGrmDzIKBxerpkV8QQUYfEWHXfd1oZ/5gOMmKC/1zLcYWTVcDMoTgRgn
         zW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4ZRMYDD6VXYHJ3yMoR9yk/ycrqO0+R7vuu/Js8ejT6o=;
        b=pVWc1Ld9/gme8C5V2XIb2C2F2MzbvarC2nOlbRlqI5QKCg3q9O0VDsCZGZWFcF4wnv
         6tqYB8VL5R5tSKFe9cZGwieAHvQ6ikpl8EmXHB2yAeIhIWXdCSxqzbgmM8GtLlpwjMbh
         JqykVtlFLFbTPxEJ5ZWVcrUzcP0oKVQ/Binju7IjomYFNHX7+TrFLPBUF8xzxxV0KH3H
         9rKE2upW7MJvSX77rvyeJSDtHD8I6Tpn085wPxEdRRdfLF3ijYN0o2xE6b4pMUTQawC9
         kL7wiWcCwshaVOuG857o3MbwBOGRy1h+wkU+2P/vQC+Jtj3s7z7T5m3EPYqZvTc380pN
         hIrg==
X-Gm-Message-State: APjAAAUGNdv9wXgG91qsdsHhjC/+8ruiAy35VA4cmy59LjTjqy448wb2
        WCI8S91p41pyN8bFgID7FFI=
X-Google-Smtp-Source: APXvYqwoqguGGXI4TpQM3iac73FV4MOcZ4DOAi594SuTbNqrfAuxV0KxH6IJL43f21pUqpg/4v+hnw==
X-Received: by 2002:a05:6214:10c5:: with SMTP id r5mr5250487qvs.224.1561583777110;
        Wed, 26 Jun 2019 14:16:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.159.13.12])
        by smtp.gmail.com with ESMTPSA id d17sm6488qtp.84.2019.06.26.14.16.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:16:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E0C141153; Wed, 26 Jun 2019 18:16:13 -0300 (-03)
Date:   Wed, 26 Jun 2019 18:16:13 -0300
To:     dwarves@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        David Seifert <soap@gentoo.org>,
        Pavel Borzenkov <pavel.borzenkov@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Wieelard <mjw@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: ANNOUNCE: pahole v1.14 (Bug fixes)
Message-ID: <20190626211613.GE3902@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
 
	The v1.14 release of pahole and its friends is out, available at
the usual places:
 
Main git repo:
 
   git://git.kernel.org/pub/scm/devel/pahole/pahole.git

Mirror git repo:
 
   https://github.com/acmel/dwarves.git
 
tarball + gpg signature:
 
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.xz
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.bz2
   https://fedorapeople.org/~acme/dwarves/dwarves-1.14.tar.sign
 
Just some bugfixes, notably:

3ed9a67967cf fprintf: Avoid null dereference with NULL configs
568dae4bd498 printf: Fixup printing "const" early with "const void"
68f261d8dfff fprintf: Fix recursively printing named structs in --expand_types

Best Regards,

- Arnaldo
