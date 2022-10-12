Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AC85FBF24
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 04:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJLCY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 22:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLCYZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 22:24:25 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00078.outbound.protection.outlook.com [40.107.0.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A3E43E59
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 19:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOj0nFonGTuzvEdr4uQy0EYl0bTNxxQ9jgJtT5b2UdVqUv6eHfN4SNmT81qtQugK4nWsZEbZ5ROGThMVjZ72pHMVgirSQ9KXPybuNz3tT5IyuigpEg+uDd2RSsEkIdQH4eM/bsSWbKrLR7Nczvaf6ZPeeZxkeVtM4EXufCVsEKwxmfuLiWWxXaPJHnaXlrSKAepO/u2/bePf5EgIeejjM28mVwzrrIEihYrnue+MEtdsusVWMgfCipnWzSSBzWCRlWOFNbeeJjxsnBNFbmqgfc5gBkD0nzytgivZcXhSOVHTUAZvWvDKkJxbuTv3QKZkUxkYSP5u6fxo7wDwBnYUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZkNXb7B0uyK/NKhFbwGylKUmGxEn3mp575L0UjyFBM=;
 b=Hvg7iV/2h8EVrAwRFKVqARfqr+B2mYXQgvojiz9CiriNq0ehUgSFrS2cbk7NAY1m+M7z/69++4zAjKsxL1xNFNkxTjv5OMyVtyjyfAVtk92JEPKGNlFxSMxwgcIDqwS1KfYiLRGmagYPXw7YnhmeWPBN9GiboBOfirflo9wO95WlJYVr23c5pIiQg2armh/z2bjbOM13yJOOfzPwqbvtOYzjl3iVXYGJ1YnkEBwdCPCJfY4YvjzL4fOsoMhqt5c+lGtFBsOnikTBBoSiZoiFGOvZlez/0dm/oE0QQlwkarofGuoEE0zHP1k7QWIGPYhBZJAEOnG37ebfy59ccKU38Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZkNXb7B0uyK/NKhFbwGylKUmGxEn3mp575L0UjyFBM=;
 b=0VEfr1t1EgYwL6FSYsls61F/DDnEJpd9Rtkax2hUjrm4M6rzUo2FTfMxKTsanfNIDBnLq3wJXGcVMWIKQJs1BDJTWkxZpXd9pyaITT7Dzwf7HCBlkf4JD01aXsrf7USrN7iTnJU1ijogb3E91UGum/rJT35BpHWutpPNelbdNfMUr1XP36gr4CyEn1bL3qjrqKFrqltvii70jqLRdVw6gCLYki/ze9WomeahNUuc9q00ypZUGt8Boht3Xgw9jxkr9bp+eMP7ox8hkXJOqpGmh0p9ZkF/iDKHfWJTd60a+vk1WSRTrT2P4fHmm11g1va/RLWanF8dQ88N7cTKqMBEpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 02:24:22 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 02:24:22 +0000
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v2 3/3] libbpf: fix null-pointer dereference in find_prog_by_sec_insn()
Date:   Wed, 12 Oct 2022 10:23:53 +0800
Message-Id: <20221012022353.7350-4-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221012022353.7350-1-shung-hsi.yu@suse.com>
References: <20221012022353.7350-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::14) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a81d24-324c-4595-7de2-08daabf8dfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P2hifbdKGNsEzl77RtbsYWj/Ce65d9uOELEx8rBP8/EtDiuTl09OGXlP/IkH9+y8ftWfxwkhTKh1botcjosmI+xxWELdEvsVpuAzdSN80mcef3knD/RQ7b2Czojt4bm6qLfbVa2V9UDRpgkAkoXc6526jOg+NSClQmJ1uvKLC8xldQAv0Rt2NdMTrTfyzCpDInwtef7a+RtjVkTr8DPSfOnvGCyI7IYvIJPJJhN8dFVug0cFfl5PT5fdt4jxcj87v+xNeY9z0ACK64SGQGT/pu1ecd2z1Of7OG+qCkroVFoykIghzdzPQ4tgyLRU1NbW85gmaEpQe06KiAVdvj1hfgHiV5R6Gh5H4amnP68/CfTTKe2j4kAHNXKUx70+pn1Z96DzexxgZ1Iwi64SG/Z58wL9AmnBIQy3AK4jOkloaHjGGNbEQrznTDzQmaEQtwx/foqltsb6iXOYGNPdIOp/w8ak8d7ke8+Cr9w8Zgs+4c/URcxLEPrSBzmtngxhuTkjIqRh0Dwh78V8c0ybU9VlZR+FPEjoOd1eIz9/I52coKDN7O80TEO8m2UTWs+Hwh5097hD/GGsUC77VIkZlI9LA0GlWZs4oHAZlZfXi3tt97r7qt1544OS3y54rF9vWhZHS+IHErJT5ivrxOnV8NU4mZXjE5H5qhn+1sMppqf2m4x0mWiyHuxdx5wG0OBabJqCdEAASenMateaA/AQKnCLrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(1076003)(6512007)(26005)(186003)(316002)(38100700002)(6486002)(54906003)(36756003)(478600001)(6916009)(86362001)(8676002)(6666004)(2616005)(6506007)(83380400001)(5660300002)(7416002)(4326008)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJA20/Kh+kjBwI5AUUke21AkeS9zTxzkDukS5qLoxluYEOSgl2PlG87j206a?=
 =?us-ascii?Q?NlsLQTuFTM00em44c+eidjgTI/fa0pazgJ4EqHe575M12yw6170FBjfNhOrN?=
 =?us-ascii?Q?KHtt+E/0xcI3GYDtaHF+YbZYL5F+9MONe7bk8v8+3858d6MwVvbummjWqRF1?=
 =?us-ascii?Q?DHl1jYOtYwsXT4I6EfNRK2o6sRB7oZSuDvjuUEM8ou2UlPZ9ODqS5DluPFgA?=
 =?us-ascii?Q?tFa18ZqhUuGfsB0tFfy3+QGIKcoq0yFSgn9a1wUDnxDqbvaoGp5sRlTdtDAe?=
 =?us-ascii?Q?3FXaqfFmtAaBU8y92DB+SMu6EI49ZSUEE6EsCaOnlv8BgLCseOFAb8yFyc5i?=
 =?us-ascii?Q?IReoVSgdHYUUNVgSikcAKMy0b+OBrXUGl4W3mfp2B2vuYuSWeAIEMH2fKdfY?=
 =?us-ascii?Q?HdFNx3TVcnTFBho9Mljn62lhMvR7goskJbjFs8HrQeLLrI5J13lXSb7sDHd8?=
 =?us-ascii?Q?e25STkuIwM/3Iyiyt5L5bI6CM4Olm/yR0f7u9j/gV2HWquCOhnWaLL1NTjuD?=
 =?us-ascii?Q?cRqihNMBK6zkK9vaw2EVmLVo5rs8HdEirQErzAwDIVTWE2vbnuHrr9Ogu5tX?=
 =?us-ascii?Q?c/lpHFQoRUiF0EPBJfToYOryetf1UDcGn2twGW0pIyIrpGl93CPRCn0sf1qV?=
 =?us-ascii?Q?8y/VgULDY6m3JzNECYk4wCrNNaIPR06Y+aeiY7HLlKmpLlZXrsATFqnQq8Le?=
 =?us-ascii?Q?E/co4VgIjeoIv3e0FWtsZL87Cthi9Y+qFJso6qqz7/G/GHEV0rhGIMVuMH+k?=
 =?us-ascii?Q?Wrl3vtWndtVBk8lT+xiYLTfdPe77X/ypMK9o7nzCtEWEUdN1B2Wc/AMjVgVO?=
 =?us-ascii?Q?1I7MThfAJRzuXbq2xZl5nAJZxYg9kbyFitRiQV/NxMlZbXvkU9nStr5lv46H?=
 =?us-ascii?Q?ALP1/kYU5CqMtMqXWt6ChI2Rec4TPlbwKbR0ettG85MglF14QXkK9ae6k2Vy?=
 =?us-ascii?Q?67zKzKhBQiv5uT0cOOMD/MHh84DuuYCa90iQwcFb7nMSNlqGEC/CZUvgjYAt?=
 =?us-ascii?Q?euzh7fRWItHXlfQk9zdSmG4uMLyuo9CJqcdeXmoF9YmVJON9Qg6RXfwaYD0t?=
 =?us-ascii?Q?OAMdC3xpDvIb2aFCDE8fcdNLKRjZEsLbPfwSS5Bb0vwa6o5ZxHo8PJF2IXgZ?=
 =?us-ascii?Q?Oc/ka8r5fdGLs7fYyu0Tshdtdmzh0cUqtMg/+0GIoUB2IEUSt7AviVzGqPsG?=
 =?us-ascii?Q?MaTcH1blwnW1brcShX0BFakTKWLZIdf+Ae43DPJaBBjC/awis9wpOmm3bwRX?=
 =?us-ascii?Q?Df2XLzWOzmFKgao+s4jvKTZpC9vLonlnxFLlDvcqhvlqToJtXuRH5sn2lutv?=
 =?us-ascii?Q?qliBQHsk3/FmFOURU9gMuysJVege4OpVKlAvQdAwY1ONy6B+omzldMH1/wdZ?=
 =?us-ascii?Q?rIIKnFh3kXBRTa6aTm6NyhVgVtblfEB0GzI/RZy/osQSw/Vq8hzx4w+93+Mv?=
 =?us-ascii?Q?V5wh4gI/HhUcE8NWbAVqRtRZSUWCcB8ZDasHx3eGziziRtwfe4NbcVO8kl6v?=
 =?us-ascii?Q?xzVP3pYkMc868G6zmtxcyzo1uhtnfR2yK91yi3003bJj/887GzX4p2fg/91g?=
 =?us-ascii?Q?dtKm6kQ9luQ+Q/cHhFdWq6TGrJU095ySSro0pnpI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a81d24-324c-4595-7de2-08daabf8dfdb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 02:24:22.3851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuUI5ICDQF9YLNTZYU81RhX4as8asaccemqTJXZwmt0HyhAM2u+YORd6aWQ7ybBJnuzkM01OgQn6FYNZrZAV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When there are no program sections, obj->programs is left unallocated,
and find_prog_by_sec_insn()'s search lands on &obj->programs[0] == NULL,
and will cause null-pointer dereference in the following access to
prog->sec_idx.

Guard the search with obj->nr_programs similar to what's being done in
__bpf_program__iter() to prevent null-pointer access from happening.

Fixes: db2b8b06423c ("libbpf: Support CO-RE relocations for multi-prog sections")
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/lib/bpf/libbpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 29e9df0c232b..8c3f236c86e4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4115,6 +4115,9 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
 	int l = 0, r = obj->nr_programs - 1, m;
 	struct bpf_program *prog;

+	if (!obj->nr_programs)
+		return NULL;
+
 	while (l < r) {
 		m = l + (r - l + 1) / 2;
 		prog = &obj->programs[m];
--
2.37.3

