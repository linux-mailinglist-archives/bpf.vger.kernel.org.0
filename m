Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA03597DA0
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 06:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbiHREgF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 18 Aug 2022 00:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbiHREgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 00:36:03 -0400
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE14A9249;
        Wed, 17 Aug 2022 21:36:00 -0700 (PDT)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id B03A514080F;
        Thu, 18 Aug 2022 04:35:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 8236420010;
        Thu, 18 Aug 2022 04:35:58 +0000 (UTC)
Message-ID: <50ce72e61bab598a04714910ec7373818a006035.camel@perches.com>
Subject: Re: False-positive in Checkpatch
From:   Joe Perches <joe@perches.com>
To:     Matthias May <matthias.may@westermo.com>, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>
Date:   Thu, 18 Aug 2022 00:35:57 -0400
In-Reply-To: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
References: <5c9edecd-762a-221b-7aa0-f5c2025d32d4@westermo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: js61r7mbxaq5z1f7sp54q3kf1du31cib
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 8236420010
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/B2BHYHiPzvlWmf6zkkp0nlTQ+i8dO/Uc=
X-HE-Tag: 1660797358-796025
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2022-08-17 at 10:29 +0200, Matthias May wrote:
> Hi Checkpatch Maintainers
> 
> The selftest patch at
> https://lore.kernel.org/netdev/20220817073649.26117-1-matthias.may@westermo.com/T/#u
> claims too long lines.
> However this seems to be a misinterpretation of the indention before the printf split over 2
> lines to exactly not have too long lines.
> The false positive checkpatch results are also on the netdev patchwork:
> https://patchwork.kernel.org/project/netdevbpf/patch/20220817073649.26117-1-matthias.may@westermo.com/

Each character in the boxing output is actually 3 ascii characters.
checkpatch doesn't interpret unicode within character strings.

