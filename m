Return-Path: <bpf+bounces-4754-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1074ED35
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BBC2815AE
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2D218B13;
	Tue, 11 Jul 2023 11:49:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0744018AEE;
	Tue, 11 Jul 2023 11:49:16 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2096.outbound.protection.outlook.com [40.107.6.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D41110E;
	Tue, 11 Jul 2023 04:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIrAosaCYe4BZwYZUKPAQrZbd6BO8MLwVwGm4LQUTxdyiTWrcP3DTH5Jow/r+gJXtB2sPk1yLX314aiIOE/q0QEK1xLQxwA1wnEtXLfA6V3i1YqY0VGckOvCianR8d95SJr/rJ5Cm2lTiR38EH+4fq53WyKnwqQsd1oL5HZayYJbC3Js55DpuiBdluRXEvFmfDrYuCuaRN+NiCCCNFyfkkddO8rl+RKL14ctuRKh99HoJXeRx7GyBs1FTwfkBv8iReWoTDVn7o2ffLGF03kjqeMBlG/99RygG+ufBjHLgSvSpcCVh9O34SneIU78yNSFDHHjNQf28yyqjqyscT2M6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbZBfUWQI+43/vOZKW9/fSFbvy9yYN1LvVvWgxmeuNg=;
 b=NhIre9ubOMVffzjgOUt7LGV7ejJ1kLZvu35Lh+j22sHO1lutw2NyBjmMx5hn2msghcwcQj2cb+vqpgJBown3PUhDBIzr7ygXMe0RTQ6skcU+VBlfnCwVG5+A92+oqkvHaY/54mZPmr97I0rYsjY3xugksSWv4TCgYH+u4mgUpueVkrelpekzNs4UTXdlK1aT3k64GG+BBi/R4DpXJKe/hVOxYlJDdpqOTMBerfOgTaXuPGg7JuOmgM+R7Wps0MPz7GKMjO6mtI35UQJrly5S4sdQCutQqShkoFCUBaa40tJqj0LFkVuXjyr0rVEVKCWuoVsNf0SddNmmQLTp5IG4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbZBfUWQI+43/vOZKW9/fSFbvy9yYN1LvVvWgxmeuNg=;
 b=cO529OxZiX3BCBMQVJALIytIsuIFC9kjn5nrfl1LX04xyL7RRa5FwHwYirm+nZ5FEAPE30XfYl3JHCtoUFXaWyHV9ilXEpdW3VQ92uMTFESHY26fRItM+ftGy6tfZIJaqt5Ga4YufTxbwnwJ2oEHe3c2XUP2dAxmE/e0Z3Ib1c8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB2088.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:517::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:49:13 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:49:12 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Subject: [PATCH iwl-next v2 0/4] igb: Add support for AF_XDP zero-copy
Date: Tue, 11 Jul 2023 13:47:01 +0200
Message-Id: <20230711114705.22428-1-sriram.yagnaraman@est.tech>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::18) To DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:1e7::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBP189MB1433:EE_|AS4P189MB2088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5cf0c1-c652-4a7a-9ba5-08db8204d87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fe93bP87U7/aVx5c1uXhjtYQhF8zeCUTGJAMlwBgYoot9VVAUoIpf2cQ/SQJ2MLKlMPFfW0oN6hdDLVSxFEl1IhiRf6ZEkwFIE2ccALQRxijJsBEdghHafIP0MoVmUV9nw49428LM37kd/mA9Z1YeweFIXW66uh7JD/G6EQ0aEMiMl7GeS2QcUMX3RpcKlPzchDEUaE0NRc96vq1lpW5ZqUjgadd5UrMXw57Z2WltbCy9XsGzA+7/SXizGMYbtosxqxuiXSmRphxT/EsDtrgd+EQdqgogXInSwPXD4J/q8F8wiCAn4n907ZZDKlfDMEbAQ1qwILaeZqQRqC8PRhGxPbAKxJLCHTuciIbEK5JBYWcgEXy7/Yde41jEpMIz+2yUq+YJUUodEGm4rGLYwsnfH5vtFrWwGnAVfoJwncGNnxFD88epxOkNaTGCj6lp4gBoH9y9ekQcL0atcm5JFn4May1ymBMn8iNb3xbLtjq1X51ZVszXyJCveC+bJXp7NwhpPmxij0CJloI3axqUjfczbrvZmqJUQOqBWPEBJ1PgQvyL+bLOAp/nneq6vyrP3sHBMOoUEg9SBV7mpOzizeRfRTWazwrKW63daVICQt2kHdd58d+TqBnuyQeOi1aPeiSi9QXH7KSpJDbL7HPzqhxQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39840400004)(376002)(451199021)(109986019)(6486002)(4326008)(66946007)(70586007)(66476007)(66556008)(478600001)(6666004)(26005)(1076003)(6506007)(38100700002)(54906003)(41300700001)(6512007)(316002)(8936002)(8676002)(86362001)(5660300002)(7416002)(44832011)(186003)(83380400001)(2616005)(2906002)(4744005)(36756003)(266003)(37730700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kn+xlfxhWzlMh9vWNjiWBAAydWYJTO9D2myRnG40bxYFiYK50F0WO83hVwp?=
 =?us-ascii?Q?iPAw+aS8TEY6/83XZfpZvK+qu1RSX0OdVQAtpTGJlR9mbzppLZegC3dYkRQD?=
 =?us-ascii?Q?gEiCe1tm+S8xG7eQxEWbjTwjYwLKnIGGnGr3FjzIhh89iWpvHRCtl/h3qfjT?=
 =?us-ascii?Q?OcEf1TrC21vIhDC87xdNfE8eU9jbYZFd6/z96gTUpLb6MF4cXD6Sk+85eEYW?=
 =?us-ascii?Q?5Q3fBvA2FylLStwnODpxQDvA/6Hw+Zx/Z3j/TxV66aPMZS0bnka+YNcjZjJX?=
 =?us-ascii?Q?n259efW1Y6uvDdIkMmXp0ZH02xtyzW4BVcRUbtiAnnxaEJ5a+biwyFbU2vua?=
 =?us-ascii?Q?rDXw/sLCDYpDmDgr4KWAEivCpbsKAk8M9Or36LyF+vzDTu9P9dP3yiNR9vH0?=
 =?us-ascii?Q?WseFHA+OlvnvYAfKpB/lA9k8ddVpF2Q7V0vXdCVES7K0QryBvKi/qz27xb+g?=
 =?us-ascii?Q?Ur9kg/8TAuQ9QwpGxKfsLLCSr1lfTCaZhI58ZpKRi/eV1SgC4UG7Rk5sHmHC?=
 =?us-ascii?Q?5ASHyPgMqgzzZf9GDprKly8RJhR1t2hpEfZVkKTYzr9QKsFFKaVBvv+YulAE?=
 =?us-ascii?Q?pEaDZjFrvdgcL4b5qdEpk2yCqcUiTXkFqFR055e+ubBmpUHd3taYT07mvG/o?=
 =?us-ascii?Q?ZXUQnQkzLrnMs+gKFhoEpMmHSlD7T+1zjm4z8dF3ytJYbkzJ8ataJHEKD93L?=
 =?us-ascii?Q?wGJW6pQVYuMEMlMucilEHOaqJwL/cxAVUu5RgTazPstHxJpifOxR1Og8ENHZ?=
 =?us-ascii?Q?a44YNbFXLOJ/aKPDyfg/MAq0HGb7w2BC8KFfCaXLN8p0S52QzhpFymeli1oH?=
 =?us-ascii?Q?Ibf9uEF99/+LzKqmacGTY5l5eXHFD+B9xaoVYRNAcp31m/9BmkzcrdrKhct4?=
 =?us-ascii?Q?hcxFZuGVkopjLfHiZaxet8PZ3SwGZH+pytlH9fFHAi0G6kZGcX9wCP36OV+t?=
 =?us-ascii?Q?deXmeiE0UAUwGV77eUu57AGAuyS2w62cxZEID/8Bj2GkiH5U1E0HwPpXQPBQ?=
 =?us-ascii?Q?luc3vHwBmcWQVAcsVVsZCB0XD8+poEd8UQXLp/q9ZdX/Chq8bgo6ZDvBG1Wq?=
 =?us-ascii?Q?sSelSNSbHCIq1GzQui0hx5xQVmU2WjddLOPyPvwumUpfLq7yS2P/MPTZVHeL?=
 =?us-ascii?Q?vN+q4xJgr5bi8004hg0foYgO6jiKp4Zc3Jf3+DHQzPZ0B8Rst8l4pnJgaUhD?=
 =?us-ascii?Q?YMTH4v9QS86MPeC91cSnSm2lNyXPWCLqNUneHQW2YFFDYTkMjmVXHWkHdmvp?=
 =?us-ascii?Q?66r3o81H2pPfQTsHYVKkTxZSQE6NYlIJlHY2CH0Cn3u6FpLjrGHuxIQLrm58?=
 =?us-ascii?Q?2NOa89RVncIrLxvtCJ/TSmkM6IAltot3kCC5qCd1mIX8Q8hDh+oGm2r2K+0S?=
 =?us-ascii?Q?BhVNjN/kUYr+TYBhLlm4z8531u7RHBk/Vmb5EJk9i6V2fUMu+tLv5/TD6ETp?=
 =?us-ascii?Q?jt/i9InixdW099GSdRLwSf6r8u8WLkmjLrZ0cHfsiq9ZnbbsmMr5MQw4rJey?=
 =?us-ascii?Q?/i9kb1Pn4+WCkpzvDimecixPdOCidEUFnwY418hB0f3E5/mhVGmViTYb0MZc?=
 =?us-ascii?Q?DyYsdJ22kmchrp8uX4DljM/UWpipRzm/7SvLKox7mUtwsctYkjamFm01G+Xl?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5cf0c1-c652-4a7a-9ba5-08db8204d87d
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:49:12.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFbR0Zz4hmTCeNR4V2q35ur4zGbJpqmvJITandQCPNGeUN4PgIEKUMDJUXr678UzliuD7gKBfrvQpwv1ntQaVsvOm7gvjmM1Pah2eQoke14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB2088
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The first couple of patches adds helper funcctions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

I will attach performance numbers to this thread in a couple of days.

v1->v2:
- Use batch XSK APIs (Maciej Fijalkowski)
- Follow reverse xmas tree convention and remove the ternary operator
  use (Simon Horman)

Sriram Yagnaraman (4):
  igb: prepare for AF_XDP zero-copy support
  igb: Introduce XSK data structures and helpers
  igb: add AF_XDP zero-copy Rx support
  igb: add AF_XDP zero-copy Tx support

 drivers/net/ethernet/intel/igb/Makefile   |   2 +-
 drivers/net/ethernet/intel/igb/igb.h      |  35 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 181 ++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 521 ++++++++++++++++++++++
 4 files changed, 693 insertions(+), 46 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

-- 
2.34.1


