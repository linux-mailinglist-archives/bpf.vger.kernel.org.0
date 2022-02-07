Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8D4AC525
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiBGQNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385424AbiBGQAz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 11:00:55 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2109.outbound.protection.outlook.com [40.107.101.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DADC0401CC
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 08:00:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aynFlnNAx345KvU3EDP1/lyuEf13IAfaFTLxEJSDqSoZgzR/C7jb34u8rLkYAtQFVxkv2Ts/dHVqx5zbADu9x963dQZ2fQDAcQ7NSFb2XI1mZwJj+53KpxNJTQQyHOLeS6fm1B7sUmex6p3KXkoow8AQa3QbsdqTbuvuuuYVTGhfkASqyAyRyrPi7z2Su8//AB7GWnXfkS89giYVXjSGEzpGRqJeaa4dIh1M4G75BBma7UOEPythdd4wgXCdWf6r2P7nWcDBkqWHopdScuGiBM+eu90oKetV+Nyz3sUPYj7xB0UcnjiugrXHyYZbQoaGcNd8mDIUO9tXaukfy6QuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xPf2t7eUSOg6esxn6NqXFrCTw8Z2HfTUVf+WmOf0sA=;
 b=EVp9FrwSIhwgQ+fpuImJzVgfsqEu6hJBbvUZBkutrM4Q7Uv1ov0iWjeLG6GXd0XweWXjwG3JcObuIildh7LaWGI60G/hQMtkQJ1Gk21cJ8rELSpX+NVwV+VTCiDa/VSO91qRVzlD5oFs35WxrDU4Jlg6y+8NLYnYu4wJ19Ev/cYWDwdrNn3akMgyOzyUgygX3rA9gHO7F77nRzI1efWTI2rgvWd3TiNqoxXHd35D/Ys7agn1EFZtmYjIo2UWZ5cWn6Zr/JIyNdHzT4zaCYZHxrXa/t+TmZnc4iAR5AqXCQDjQ9K9eJL9mnvUCL2mVAII7GwCk9Kl7FglfmB/senvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xPf2t7eUSOg6esxn6NqXFrCTw8Z2HfTUVf+WmOf0sA=;
 b=TDBPnZLbnN28PQ2nLwouxp9lnpZYprQ7BI+ykZAUnAneyaSAaTTjzsgtrEqa8fYBQanyyhf8m9dESgvkqQh8eL1pSrvOQeyFMMa/FCBaQAf7bhfF3rcGw4aPgSJyhN6uXBRBYAjqYJt+PwxzMRjp4kmwykUV/wgDCc1I496A7NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20)
 by BY5PR13MB3332.namprd13.prod.outlook.com (2603:10b6:a03:1a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 7 Feb
 2022 16:00:52 +0000
Received: from CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::84e8:4c19:d6d7:a8ee]) by CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::84e8:4c19:d6d7:a8ee%4]) with mapi id 15.20.4975.011; Mon, 7 Feb 2022
 16:00:52 +0000
From:   Yinjun Zhang <yinjun.zhang@corigine.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        niklas.soderlund@corigine.com,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf] bpftool: fix the error when lookup in no-btf maps
Date:   Tue,  8 Feb 2022 00:00:25 +0800
Message-Id: <1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:a03:74::34) To CH2PR13MB3702.namprd13.prod.outlook.com
 (2603:10b6:610:a1::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b03540b-bd8a-40ac-9999-08d9ea5303fe
X-MS-TrafficTypeDiagnostic: BY5PR13MB3332:EE_
X-Microsoft-Antispam-PRVS: <BY5PR13MB3332FD824B2ADE6866814E6CFC2C9@BY5PR13MB3332.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgJ88AFffr2s6Iu65LDy0KdolNXYIbnuWad7eO97TFdGat3jL9i4ma8W0vVR30DZaEIU9j6e2QzbhoZ5B+dkTqrLM8YCRcKRuN0P//TBK2yYJOG5I07S/5KACw/S7lxbguzv2aBlRk69Cn5roeaXxtL2i3umU5k7BN0FnYqtDyi2ELqY8ihkRJnAu4Gs4+r9DhHA9qAWmtf96jOcfJH4rsprBXOwUm62NVc4/L2fYxkVZbOJTCr4nFvx9XBkE1RM5KSDP0KTje9PugHHyz7y4wbqrEPhH7uDWGilhuEtjyKEJS/n1rNxf2FlnqUh9bIsvzGOP4GlurtA2ogIk00gor1xQYJx6IfqBDQTwVmB5UawO/KfI+atZNvAmBTo3yWmMWg6h9Cdu4Jetuo+V61MTSyRIqusjJ45+8k8pYjQM1fWo9tv0DwXJcSAsFKRrP3vDimXTyrjskYSpMvZgdxcB66Pyqeoi14SMeQXSV/P/TLHKcO1yUcFzAqc9SW+o9u1pj2z3fF7fgeE+51nbzATZ1t6Wn93kJci/+5izFXrzrBZfEThzynkmp6iOS5qDKKJpJz5I/KQcxd8eKUqxJX6wwbgqfvjAbrV8G63+NwrvWlxPr4dFim3/5XlnQ0DRVkWdau5s2jddyGIYawoMlZiUXRAdJEzIshQeGLMvTORXocVhhmC9BolwKcqM3dKoZfOttA1nTtT5w4ysRCr7S87J7CmaIYMsA3wZFfQCusgvFvTyCsu1hdTecUE1tX4/zKb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3702.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(366004)(346002)(39830400003)(376002)(136003)(6512007)(316002)(6666004)(6506007)(54906003)(86362001)(52116002)(66476007)(8676002)(66946007)(4326008)(8936002)(83380400001)(66556008)(107886003)(2906002)(2616005)(26005)(186003)(5660300002)(44832011)(38100700002)(38350700002)(508600001)(36756003)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBBcUhoRkZTeG9Ddks1b1lHdDRhV2pnRDd6OElNYll2dDRrV1pSLzhtUEQ0?=
 =?utf-8?B?RHhyRnN2K2RoYXUxOU5VYlJUNTJUNHIrbVM4Y0xNc2l6NkQ1cDY1aWlPTVR6?=
 =?utf-8?B?NFpGaERMOEd3RUNDc2JSVkRFenVLVjNrbndmMVZQRnNZY2Q2N29wQ2E0bE56?=
 =?utf-8?B?RW00dnVaZ1haK055bWJZdE5WeWJlM3A0OGdNY1Rzcm5GRzNITTZxcnd4T1Nq?=
 =?utf-8?B?bEd3QXIyQ1dOOERnOW5CZ1hkNUJ3VE5QRmdCUE1aM3RnemxsQkdLdkVrRWhD?=
 =?utf-8?B?dTErQkdDWS9wcTdhYlNveVVyVytqc3hzcDRJei9BSjBTUU1pc2dwc0t0T1Nn?=
 =?utf-8?B?VXhsTjJOTUdCaWR5T0VvYnFjSi9RT0gvbzZDTUVzdU01Rzl4clJGR1ExYURE?=
 =?utf-8?B?RGlGTlBnL1ZRay92VnQzcklVTjU0Z3VZVlMvdlc3Znp4WGxwZXJ2cENMRVdR?=
 =?utf-8?B?QkVBLzlMUnRVL014QmF1ckdxV2VRZmpXZmtiWXVuWTJIOXNYeUlBZDVQWHFY?=
 =?utf-8?B?OVZUeGlnTDU1OGEwZWU4WjdiazhJdUR3ZndwZnVKRzAxLzk4NnI5YVV5ZFBG?=
 =?utf-8?B?aVJ3a3ZrMFd1NW40MlVzcGZSVTErMURCWmF4a0Rwc2FuanNwWmZiUVNDek8r?=
 =?utf-8?B?MFZhVHhmT2dNeUgxa1I5bWlIS2E0cVZmSVIxZThRNXlVWERqUENlZ29WUlNI?=
 =?utf-8?B?V2RMMGFsc0VyZVk5YzhGeldBVXNTSXZXb3ViMkNjcnBQbVJMR0VQOVNoRHRC?=
 =?utf-8?B?bDRQNUZ3TnJmTno1WHRWVzMwb1BHWENkK2FreHhtZ1E2VmUvUkV2WHZWUEFk?=
 =?utf-8?B?Yks4NmRyanN6UTAzMW1uZ3FxamZQS3ZpTWhCYUo2Rmwrd2FTNXZDUHlRU0ND?=
 =?utf-8?B?eGxNbDN0SVQ3Z3lWRTZXTnE4RUtOeVM3NHJZSHpBVGVJRVlHY2Z1UXRnV2JC?=
 =?utf-8?B?ajlLbGdCQmNtNmdsWDdiM0M2YWhkNGt5aTBJakdUYVVndGIyejJyZHA0S0lD?=
 =?utf-8?B?YmZEUGhYcFlCUlJRdnVSN20rNTY1djhNWXJVWWdwMGNEcSs4MzFDK2pkWW9P?=
 =?utf-8?B?MkpwOEIrdE9MQ2hNaSt5SzBwaXlxR3VsTHFFdXN3MlhMVEt5akZyWFIyR3I0?=
 =?utf-8?B?THllQmF1Y3Q2QnJMa0h0S1ByRXI0Z21aUnRPcW9oYW0yRGRBb3A1dlhVaStW?=
 =?utf-8?B?OVNHNnBTQThWYVNEaGI2alVlRFQ2RnBkZnMrZWV2V2c5RFlGMWIxNXpvakJv?=
 =?utf-8?B?cmtxVlZCb1FwamVweVAwVHFFKzFScms1TWtkbktmaENZSlpiUldoWVB5d0gv?=
 =?utf-8?B?YU1SSms4MUVvTnN6V3FFMjEvTEVlSWVsTHI0UmorOGl4VkFIanNVRHNraHNL?=
 =?utf-8?B?NWlubXcrMzVuL01QbklsZS9SNGtMaE5EcVovNmU2VzBMWFZwRU1tVmdhcFZr?=
 =?utf-8?B?dFNvaDB6blRGK3RxYk50L0pBV3V4Zkw2UjI3OTVTRmRxWTBIcjdhM05xS1o0?=
 =?utf-8?B?Sk5TNXVqdUdWcjMvY1phMVRnNVFucUo4Zkc3VUluODN1TU1IR1Uxbk9tbzda?=
 =?utf-8?B?MFpPOXBvMVVKS3dEbVRwMUVObElJemJTOTRaajE4RVRxUVJZSkRRNEFIQjVX?=
 =?utf-8?B?d2F1dWZWakppKys2bkJXa045QUsvOFlHaXQrOFFITWpscFIrbjRvbmdTRW5w?=
 =?utf-8?B?MFVoTUk3bEpqYTk1WjViMWlHREl6VGVROHl3NFllcG9UaDRHQyt0VUFBZXE1?=
 =?utf-8?B?M3BBclR4cHVNTW9ONlZyWlNRMTZwNUhxZ3I4SWpyM3dZOUd5ODdLcEtsTkVI?=
 =?utf-8?B?cFhicGVqQ3VlYzZOSVduNmNOU25PZGx0YWRLQUdKN2labkNSTVhUbUx0eld1?=
 =?utf-8?B?ZHg5RkFvVURtekViRldFUEVsdjlqRnVzUUZEVm9PRW54ZXRBUVhrdUdQbG93?=
 =?utf-8?B?YkpWRWZGcU41M2dUd2thZDJrVlJoYUQ2NkJMdEJhdm9JbE1lL0UwUmk3My9n?=
 =?utf-8?B?QVNHNUFjcktUR0p0Z1BtVlVtcE1zb25RN2JJS2hXcDg5SEd4QkVkb1d5VUhl?=
 =?utf-8?B?aU9iRWwxc3QwL0duLy9Xd0M3YURRS1dmOWVkRmZ6YmZtQnZPMU8wL1h2S1dY?=
 =?utf-8?B?cHlXZysxRCtRNjlBVzJzdTQ1SkJOS3Nvd1BQV0xpeHpTY2VxRWdWNFRKaElp?=
 =?utf-8?B?cEtVOFJHU3g2U3ZLWW5sMXRKS01GTHFHZWdpQjR3eU9qSDNZQjNoNUo4WDZU?=
 =?utf-8?B?R2tDRm9QUW9wSHBIaEl4KzRQSmR3PT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b03540b-bd8a-40ac-9999-08d9ea5303fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3702.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 16:00:52.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQ/IukVJQn9wmCrPU/ZRhRDG0ksQ7JNnOwHLwCKUkNE3ilyT1+xFeb4HIqakQLNdvBymhTbt1AhlXLqKULipQxAqHU8PcDpmOBPLHjE9jQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3332
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When reworking btf__get_from_id() in commit a19f93cfafdf the error
handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
if bpf_btf_get_fd_by_id() failed the error would not be propagated to
callers of btf__get_from_id(), after the rework it is. This lead to a
change in behavior in print_key_value() that now prints an error when
trying to lookup keys in maps with no btf available.

Fix this by following the way used in dumping maps to allow to look up
keys in no-btf maps, by which it decides whether and where to get the
btf info according to the btf value type.

Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Signed-off-by: Simon Horman <simon.horman@corigine.com>
---
 tools/bpf/bpftool/map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index cc530a229812..4fc772d66e3a 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	json_writer_t *btf_wtr;
 	struct btf *btf;
 
-	btf = btf__load_from_kernel_by_id(info->btf_id);
-	if (libbpf_get_error(btf)) {
-		p_err("failed to get btf");
+	btf = get_map_kv_btf(info);
+	if (libbpf_get_error(btf))
 		return;
-	}
 
 	if (json_output) {
 		print_entry_json(info, key, value, btf);
-- 
1.8.3.1

