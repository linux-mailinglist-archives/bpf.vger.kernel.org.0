Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290635FBF21
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 04:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJLCYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 22:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiJLCYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 22:24:16 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00044.outbound.protection.outlook.com [40.107.0.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ECA43E59
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 19:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZVktbnfqvvoNB7Hv7V5JpqdPtERiY1iidC+BjzCh8ekhglBJupGwglnNmhEfJaprLGIEYxHSKkXI0PLeToWXmYvCTmANLnBYeh3Vax5GpxzXYD0TCdBt339OgaWkFzYtqX6JMbPY8rkXK35ry6syjVY8kz0rcDksDaRMs+4IhfR4Rs/P4Wttkc6QMPsInNGGBg/a5WC6KcXO76eLaGWLtof4LwwXo2fijA0/o0y08CxFkObPIvBFfIe5uuhGTVsqeAtKNhQOs9wqlQt2C9CdNBI+QTHWd9K3pA4VXcSaZNnrUHZxjsVgIdFHFPc4UgzpE1EvB+tY09T1AU28IT7nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRzGIxx/5yV44lnsH0i/nVQAs8363ytxsMW7EQO8cp8=;
 b=YTyvJjukZZkNbTToulSlBRYE3oKO2bc72mrA2YJ2Kry4Id2TZ+6KRn7TyrVs4SO3EGU5z2pLkHP9APrQG3cCgGk1ifcl1vg+83f3KT7UwJK7bGI26eML7QchuIVoQxDuN5LOfIMvavHmGedkniz+ZbcEpLZnjE8mj5tOUSuIAFyt+azy6jrjl2N9tVcf12gjN4uDh2ao7ztb7M3dZ3DD7yZIGnBqft8m5Pu1pvvkobqWhp9wEKBnZNDZwVBZyw2LiBQ24KLJTdg0AKPkgjh21T2zlSqlYaA0mMRd0DdR/6kbvEJInSQgxGw+LEXRc6npHaBByYKeKsiexTCu808PRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRzGIxx/5yV44lnsH0i/nVQAs8363ytxsMW7EQO8cp8=;
 b=5UT0RrdKjWfHTyxo2i7XAAlaDDCyYb5QjptXlA8zTpIH0AgA2/mVZ3et8MoMjUNzWNCnr5wcsy3sYM9frLdoHACFkKqwhTHChmGeWlrMNtqmltEwal2XHQyRW8uCNCSymHTtGGp5eiPsf3oPOubzv3TEvZoJ4U2DS82PT1ccr8l3QZ4lVd2v23Su3Z0VJMnNHgPz/2csEZCxWf4kuxDAEzSkoj8e+LBL+9V4Hb3bdk+sAUV4xnHwhkEPmFTFjQsl7QfeQ7zv+YOO+wLoK0yesERF1OqMwCd9SDyKoooGq5v5aGd8gHJvMr6/jnWlY36XQJDNwTZ51fjOtJDtYD4L8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 02:24:10 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::37bc:916c:55e:c0a2%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 02:24:10 +0000
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
Subject: [PATCH bpf-next v2 0/3] libbpf: fix fuzzer-reported issues
Date:   Wed, 12 Oct 2022 10:23:50 +0800
Message-Id: <20221012022353.7350-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: ca94faf1-0e2a-4fe5-973f-08daabf8d89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZXRwqluX+O6seBq1qSGKbjZH2H2sWAfkAKW3rcWIGR9U/CE4TpzbS9KMJprpt/KTG1SyAElq2HsV8NRVPN+lLbxUqy9R1dWFzZn7IR0jfY0M9TJ8jqev5yWjdMnc9VoruOIlb5K/0TYfujq7TLxZv0nnHxeLYuLFQ/dt7pC0PbQz2iDWLJwzVHYp5QVNDjlfE3zGWO0Kd1K6X8CNTf9d/bWj8GYRpk8JM4RJnLhLYvyK3lTiWYh6DvH5iAsAG1tNPWr9KnvMVS82ZnBUV7ONtwb3bw/+whv+1pS41bqZQOn8NGByYIOb9xEc0VVjboUaSC7LrEGkLMKSIUZjDHMlHWzDkxwKTkw0FZGTnNxZSS1kDbo3vcHq5a8W/LoJmW7JJ7mnp5faKVbsjGDj0I9rOB/EXHMLQHlYQ76FOPDSw374iPsOTedzkQqjW+NdxlaRrfbGYSpl5Gl1MPUQkBnI88yMfC3AGI02ZtMhB7GMq2KV56atAw8HLDEtNBhnN125hOXna0NLFSU9QVRbIFiG2T4TRmxsrW8syHngE8E2T+167NWHIMw3nhDx/qRM1fXFcwewE2sF9DAo223u796UQVVNK4OL/MZTJABEwvZFVLbOEAV1sAEDsgIfQb5NA1bt78KhWRMtx50UxRv+slcl+bvDo80UMsL76aGqyR6M3K79FsO0cciwtkrC463HPzZJAbdvqVpY9JpY/I9uaBodtez3+oSAWdRUcQwwi3Z2G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(1076003)(6512007)(26005)(66899015)(186003)(316002)(38100700002)(966005)(6486002)(54906003)(36756003)(478600001)(6916009)(86362001)(8676002)(6666004)(2616005)(6506007)(83380400001)(5660300002)(7416002)(4326008)(8936002)(66556008)(66946007)(66476007)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5a2tTbfY3Ws0xzFcZN+KKXKsun5GLJf7REgSpZ8KauXDSYPwXYetRTbT1TTW?=
 =?us-ascii?Q?cRUAPvCHW3CjA1vKIk2EFGtjHpAefE6yKfeijjI6/TTvWAw6PukhUjKzLWQB?=
 =?us-ascii?Q?yuZjPu8QxGQcyZnN4b6km3F82/6VndKWPMwiSC6b0afH5k38wuF7K6kj4ngN?=
 =?us-ascii?Q?xvRyaAb64YfW14Qy5SZq148lel6wllyEFZF+VCkSTxduF8HsZHdD9LvNakEW?=
 =?us-ascii?Q?0EAGsw63jMu93etlFWmKFTWUwvKX3KwNUV7sYcyxgVocalwTXLxaaPC2arjl?=
 =?us-ascii?Q?htiobOQbTvomfaeS+diMXPzEOVuo+NSCGD80yH3TqeDuDMDa48s+FndKXYQM?=
 =?us-ascii?Q?kAVp6b4O8y/V/8XVNHJ1ui49tSd4Uhut7eDLk2f7S0q7pte3mvRzEHQdXO6p?=
 =?us-ascii?Q?bPcQGJ/hd6hDuyp3Pgbt7zSG+4ldYg24Gqr2NYY3KGSIaWT+7L9N8JeSZWGA?=
 =?us-ascii?Q?FSS6prlnF+usTDSsM85Z/rIGTJqdcezISYO/AHSJmkHCK/D2i4w31NXEFm4w?=
 =?us-ascii?Q?0yE29EFwq2dxZmdsXYepH7IBIfCJXoNtefbI4s3g2rR6xTIDkIZhqFO3ne63?=
 =?us-ascii?Q?uaB9+LRK2GcXygguwOn6u72Mj5/wff9mYHumpy2E/k87DtQWTNPINB+QgwO7?=
 =?us-ascii?Q?UmA+XcAaKtD44h5C0UXl6KVRy1FeQ1v7ox4wL9eRcrX5j9fp0JMpXsjfMkny?=
 =?us-ascii?Q?wqSSdioaFtiDP2DkFzA9G/5AS1ueAyFy0eHcNbf1S11gzpnXGyl3FEG1GYpN?=
 =?us-ascii?Q?n7HROHO5lq4OzpORNqoSuEArwq8EttMfRWIKDUcaYxL3kIwnlMG4RqlQqoPX?=
 =?us-ascii?Q?1oqadMii/tMHygtlV4xPa2eZ1+IXAmp0ktmHHoe4vLikbv7oIPFZuxpIpoAr?=
 =?us-ascii?Q?5vSzz6kBnGGpHqnuegTfy2Df1sIrsVuUb3/g4LFldTxZgRLLkb2Z+nfo/JKj?=
 =?us-ascii?Q?HFufUscECcayRYjrXtlyEceI09BmKKI4Ev37g5tlwITzCtNs13AIGhOikQ9L?=
 =?us-ascii?Q?3POCst+yRAKrmyf39HD37SAl+s0hpE1IbwdCJAiGMo4jp7igwC8eCtJVkGES?=
 =?us-ascii?Q?QtWxUlTADKmtewf5gE2W1jAISn490D7D6KP39OY9BDuReFh6vs4oTDMfqFNM?=
 =?us-ascii?Q?pgxpGst0srlTHTRrT9s1XnUqUUN12b4XtntDZu/boBU9LZL9RYU+2PF20ONR?=
 =?us-ascii?Q?30HpOPh0TjK7329RBijNI/DlXkUl6ask9p7QkFIwswmvpm3ufeC5wJkhSoGb?=
 =?us-ascii?Q?1UnvUYm3bb/VbK4Ir4Uk33ssHbeql2s1JfjklIjQDIvXUbObo9wSXC+N4fMH?=
 =?us-ascii?Q?4Wyr1l8BYasiMBi3u2lSNu8hsjfDc+DzVWHbCBOq0egsIsY/1v1gu4rsFTi+?=
 =?us-ascii?Q?TLzxD7zDWVAAeZ0AOxVxpEY4+nJXicJIv9DUvz7ZVvIE1hKm5uv3ThaMGzRK?=
 =?us-ascii?Q?/VzLLFNOceQaysWMluWK78TRbsMBemDCAZflH4g8vf88H7WQhZGbNlZL7jcR?=
 =?us-ascii?Q?gA3UgQ3H+RQkrELIoSgvAyjjQ9yL3683QnEKEsek7MLWAGAeq2A7dgjunOpS?=
 =?us-ascii?Q?ySqg4uaRCqBFRKIMYOS9MJKIWNymOBQz84q+xiqc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca94faf1-0e2a-4fe5-973f-08daabf8d89e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 02:24:10.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGCoNI9ofxsFSh7dDaAn3/TSEHULnmzF+RlgRzrN1ZQH2vASDOUbrHFbX6LpfBCwQTGX1cV+quN7Ap4xZNoySQ==
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

Hi, this patch set fixes several fuzzer-reported issues of libbpf when
dealing with (malformed) BPF object file:

- patch #1 fix out-of-bound heap write reported by oss-fuzz (currently
  incorrectly marked as fixed)

- patch #2 and #3 fix null-pointer dereference found by locally-run
  fuzzer.

v2:
- Rebase to bpf-next
- Move elf_getshdrnum() closer to where it's result is used in patch #1, as
  suggested by Andrii
  - Touch up the comment in bpf_object__elf_collect(), replacing mention of
    e_shnum with elf_getshdrnum()
- Minor wording change in commit message of patch #1 to for better readability
- Remove extra note that comes after commit message in patch #1

v1: https://lore.kernel.org/bpf/20221007174816.17536-1-shung-hsi.yu@suse.com/

Shung-Hsi Yu (3):
  libbpf: use elf_getshdrnum() instead of e_shnum
  libbpf: deal with section with no data gracefully
  libbpf: fix null-pointer dereference in find_prog_by_sec_insn()

 tools/lib/bpf/libbpf.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)


base-commit: 0326074ff4652329f2a1a9c8685104576bd8d131
--
2.37.3

