Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFAD242E73
	for <lists+bpf@lfdr.de>; Wed, 12 Aug 2020 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHLSRN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Aug 2020 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgHLSRM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Aug 2020 14:17:12 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A3DC061383;
        Wed, 12 Aug 2020 11:17:11 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4BRdFt05J0zvjdp; Wed, 12 Aug 2020 20:17:05 +0200 (CEST)
Date:   Wed, 12 Aug 2020 20:17:05 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 4/4] bpf: add BPF_PROG_TYPE_LSM to bpftool name array
Message-ID: <20200812181705.hadjvarvjxwj36ai@distanz.ch>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-5-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163305.545447-5-leah.rumancik@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2020-08-12 at 18:33:05 +0200, Leah Rumancik <leah.rumancik@gmail.com> wrote:
> Update prog_type_name[] to include missing entry for BPF_PROG_TYPE_LSM

FWIW, this was already fixed in bpf-next by commit 9a97c9d2af5c ("tools,
bpftool: Add LSM type to array of prog names"), the definition of
prog_type_name also moved to tools/bpf/bpftool/prog.c from
tools/bpf/bpftool/main.h
