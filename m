Return-Path: <bpf+bounces-4850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ACA750967
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 15:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DEE71C20FCA
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16F2AB45;
	Wed, 12 Jul 2023 13:16:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DD200DA
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 13:16:49 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20723.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::723])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F7E1736;
	Wed, 12 Jul 2023 06:16:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrUWwLFpqFjfIl3qO8+50cHIFGkxJGQVss+MxTxrt1LX5skxVCEy53MxzG26UOW37LePlDOPi7dNvNU6pK7dyS8tdP+jlTbE6zGJrRtCuWO9UGX5jLWW2zfJsON15LEq46M4uUM+FzTtb8Eiv0s6gps6+dKAh0WXUcdzn6aQqJeLamOWLuBijVg8YDebqJ75jybM5SBkNAwkvqHeBy9ntpiDstPy35MExwPvifzruOjf2gWuzBuHsKxoLi9Afp0A8jhoodPMV0hjqlsadq5fJgC05dW+b4egk5igYn03fZiHR+3PXIj54Sg/edCxYYHKl+1xt8nHmub7oHnJEtWrTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VicCELjfo/y2ukoOxOVsGBQW1lULEob0ZlboaSLesU4=;
 b=KbWxoyyupx1mSkYhTT8VNf9d9/CL5J41ZVPdDReCwu6lMSqjIUGShksaLhMv5LTBmXeLZGBKe/tdCIgYWROEdiMKYUAT9le3baiEyZX60a9H++pr3gtXtxBDgt9WuY0fFi6Bk6TRiHwPZ/1UWHqRSder/JC7iX2H5pNhuplaoStPLFTGpgYpUZ+KtZ5lHEJ2o2vUonpw+imD+Ma3PXyPue71CY5bkBbKYmlFsQh620cDMk34yJsjdg4PtXp4wsR0kNvTQW+F13WMnYubL/uj2umNJwjcX2zKR/huR7aLycRya1e+OH+2bngpZwrIya+AJ8OZmmlHFU15tlHj8zYxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VicCELjfo/y2ukoOxOVsGBQW1lULEob0ZlboaSLesU4=;
 b=InTb7yIltFc7+SemRqqhm0EuToNlklWQGW9dsJEv5LlgVF+SdXFhRI+223Jm0LqnfqgRMV4zSnmGnJXRtP3rmWZyGpdDsKpfqh3Z3aIEs9LCbHSHRM5UjHjus2vYMJr71pC8iR9cWGvZZZKnb2nd2VC4UVHK7RzhIKUQykU6VNWdJCeRkPgTvVO4E37sIdLzUB7ibkBXHD4b3ahmKZ7jBkY7jxuzec5q19ZMe/lbrQ8qSc5kqN/h+GvG74N4nAROjKl97EAIvreyIzbpwirY7WdBU72BDfuL2faJ1SX5nyf8H0MjFhqpgUcjhps3aZohZL3Sg581LPNZpkrgY1yGbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TYUPR06MB6052.apcprd06.prod.outlook.com (2603:1096:400:354::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 13:16:40 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 13:16:40 +0000
From: Minjie Du <duminjie@vivo.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
	Minjie Du <duminjie@vivo.com>,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [MISC])
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] lib: fix two parameters check in ei_debugfs_init()
Date: Wed, 12 Jul 2023 21:16:30 +0800
Message-Id: <20230712131630.16552-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::31) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TYUPR06MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a82614-16e8-4738-380d-08db82da3ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I/wu01LlnRJUtFDbhEOoHRfGEBTLsh5wXsytKmUYOgCgCgP4MYtWNe0yp8FWNJ+dCFDH79RWNn2ZkpYD+9Qk7kLvvQbzz/1xpWJJmpkQ2bJVnu7N6EjHMjUq+WQyjr/UaAf2v8wNcfPZiMSz+IbyEjXNK1uWUQ33HGf7NNzaqNuCKdIWyfRqYFWoFzt4RGwxjVeAP3aUP4RbzxqiQXnUdaJ4nfaw6bquROIAv/ZVc4JJpLHBl7ivZvrIQVAduH+qK89rM6zerJ3TBI++WBTrKk2VRgNlSWtu6WdQX7COvvbUju8BiqQiS/q5yq0TgKGmKJ5ef0AR8SpAZhO0hPERhb65AOwckPv95iCPJPEomZjjH0v3Rk0uPjVwbPVvt0303jgJ6SFsGpSzuwwDZ+0mCToa5X45FfFELTNhrsfm4Yu19ILHjd1S50hxO+Yy+QFI2k56VXFDGMdSwaNCKx0l01zJeMXAoyYjiAoErTTzOeGgccQbTdZcFBRCn+uyuPVg9PBTAk1aDbGvUxWDDhwD7amDgGZdt/uamckTsRa9IupBMCK2Y2/lLaC6we+lIgaGvsCtQDYHZQl/g92UeT2+2RvNB5Np17lvq+OWrdgBU9W6+d5RwkD5ztPNmk709qJb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(451199021)(36756003)(4744005)(186003)(2906002)(5660300002)(2616005)(1076003)(26005)(6506007)(107886003)(83380400001)(6666004)(508600001)(110136005)(66476007)(8676002)(6512007)(8936002)(66556008)(66946007)(6486002)(4326008)(52116002)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqHVrrIGJM2D/7WczS1aK1eWaf4THNeN360uzDlAYCiDgoHfqIRcAz+j/m2T?=
 =?us-ascii?Q?JvgwR45bpPERjpa4Ru8sENcprq2uzot/PTz7YlkFDRJAUVhNgJ04JkuQ3jvH?=
 =?us-ascii?Q?vSxviulNUV6ObxKkTlMHxd5EV+ekjLZ68VWy/G+dQq5DH47G7Jg1ge+Ow7EV?=
 =?us-ascii?Q?RLOVbItCfYQ0IvG/1Xv7NSl/BFKVcnz8d4q+epSawmSZOjSOOgH9DPsQKHJC?=
 =?us-ascii?Q?fYFE7Aa0eYGA2wSohSWUGdAwfMJZRhypr9NeGkGGxqAUIKtclQh8ZgD0SVYn?=
 =?us-ascii?Q?mLOLHX3ZnKcRPPcVKsTNuYnZ8pr7UQ+QuYay3Wr8SMg35fi/rKR1Q4o1BHMY?=
 =?us-ascii?Q?NZxPA28rO3N+X+MY39niG1jVXNdggea15VwARaEJz8J7ptkzyr/OwW3bsjFI?=
 =?us-ascii?Q?JFTlWs1bVZToTGFFbXiWq6DRw4hTRXghRwCuc8vHMZQKp7WogyXE924nQLEl?=
 =?us-ascii?Q?RnEAn/6qxGOzUgJMHiBOjePH74oCp58/wPM5+iwLXytUxkl5OoKqmy3euLvZ?=
 =?us-ascii?Q?oTuaRljUrzgaXG891+0Le3DroxbOzvbxFLM/1gZYY8lANuhYfUpWDOxbPwQm?=
 =?us-ascii?Q?mD0igHTmMqj+Em/uUTas54pwci08BIqG06RBM/M/0RwtRhNAS9A7bKTS4c00?=
 =?us-ascii?Q?z6lFnzl8rhiqO/I8pL3Ow3dVer8E6Q9oQTvbQLb2cPC23F51fkB9IiYi2l5R?=
 =?us-ascii?Q?VRVsbvSjb14Zz8y7GC84Vk6DaRVmHPLA1Rtoj9EjcC9EQaqbLHf2TLzcF3yx?=
 =?us-ascii?Q?r1qqV4JJE6mSiHiP9k1/kWFxayyjXp8iTv4rvfH5nfl+Ma7B8ZIbCDlR/CfL?=
 =?us-ascii?Q?knoZqUrHPw/1KpHrxN/fYDMRY8PA5EjQYvxoLH8GwL/fpfyBd4qOZon8CnhO?=
 =?us-ascii?Q?XqNykrYjqRS2dofvq9h/A0B6dUIwvK7dmO9Mio9QS2bho7ABX7BVG9FlztOe?=
 =?us-ascii?Q?QF++vVh/YKyCiQ6w9XsW4BXsDmHEN6xpLUMm6Z17P714cqDF5EjSAfBYcmIr?=
 =?us-ascii?Q?gt70traxX8pYZhtMGGx4TLQVVZg/Kx+dtazUtk/DLdXt1oKW3lqPuVCpznzj?=
 =?us-ascii?Q?t1rNZjU5Rom6UkUzD/qrSLtCoZA/eM8nAY/7HH4wpwVKohWEjEtIrMGJ5YQq?=
 =?us-ascii?Q?80BlfPTH/+qlbaSZYDaxASBobavuw+ZEiCJdmTtJGoVrvp9/EfUqyT3mksyR?=
 =?us-ascii?Q?sVkg2aHrhckhPc42rpTYm8TRAYHxkpNsBjPPfzmy2l3FPLuQw7ciN+DKVaeK?=
 =?us-ascii?Q?tHXZbSrk7XGUMIkoOf2LLQiItDXK45aeap8YSZgmhRUC0xMUJc2C7dqYNHka?=
 =?us-ascii?Q?U9Di9mnJvNWlfkp1lQHrpbwwAw6UOtrxUdw6cgy7ZtfghLoKtMuz25yMzl00?=
 =?us-ascii?Q?YAR+pmRriMd81Fe/OdBlD29+epdA3unHvnv57XGjfh8xRi6Ks1UHjjaEdare?=
 =?us-ascii?Q?pdDv3idRIYtl/nrIcSYia7nmdAUQCFlptscTMVcp2SdF1spfmeP5FLt7ex5+?=
 =?us-ascii?Q?NZ2gP8fIK0sCSsI9Qp3RHgDv3elgT8fxnY8q3BsBMv6in4hfGN7Ef3TAPNgi?=
 =?us-ascii?Q?MIfcRSUPBG+v1REY994dlj/5tnsKhv8rWpR34oer?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a82614-16e8-4738-380d-08db82da3ad2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:16:40.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhbUgoq1Z49SXIphWOE+5qfK7ECnWnayt1ybohXBV0GMJgqF8GANAzWWPhAVl/NET2fLu6tl6xjP75tasfQXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make IS_ERR() judge the debugfs_create_dir() function return
in ei_debugfs_init().

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 lib/error-inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/error-inject.c b/lib/error-inject.c
index 32c147705..9dd2c5ca3 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -217,11 +217,11 @@ static int __init ei_debugfs_init(void)
 	struct dentry *dir, *file;
 
 	dir = debugfs_create_dir("error_injection", NULL);
-	if (!dir)
+	if (IS_ERR(dir))
 		return -ENOMEM;
 
 	file = debugfs_create_file("list", 0444, dir, NULL, &ei_fops);
-	if (!file) {
+	if (IS_ERR(file)) {
 		debugfs_remove(dir);
 		return -ENOMEM;
 	}
-- 
2.39.0


