Return-Path: <bpf+bounces-20121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A8C839A97
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57730B28E33
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095004C81;
	Tue, 23 Jan 2024 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7Sig5bV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZvjUiwj5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C3538D
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043405; cv=fail; b=YL+I+D9EXCI3/G6dAM34qMcCFSdRR64vIbDnU4FaL08NwwWIyU9pOeL4J8TdMiw8QaC/zlSCLReFQdFjeUzd4dhX8K+w/vL2OIfJ0e4vC9h6KbjQM5QNjr0olY2THAALdkN5VUJ1UfZx1zm6+fakP1rd28oCqjHSY7+sR90VFR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043405; c=relaxed/simple;
	bh=LeTBlz7FFmOoWdEFQ1+0rBdDs/FoNqSFBO5rHP14XR4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZEjeWt3neaqOt7bWU8q4rMiX3RjyYE94G+IM9DJmOP3JiRc40y/DNkNd/PSmrjL2J5JFOXp8+Y4lIbpqnA1jmtH/vDGOc4P0qHMxU6XZSlDJ+NVcGDD8BHbGD5hTITp+h9J4SHxDbM2Je+xpOnsBuI0cTqj9//kgVbSiBaRwCbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C7Sig5bV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZvjUiwj5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGREg0010799;
	Tue, 23 Jan 2024 20:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=f0/Uq8Wh9z5lTXuuDqdOXKpcGNRKamEpbHRlbQq3BUY=;
 b=C7Sig5bVV5klCD4PbVutUHpl1tixsr5LR0KG3E+l4l81Mu3agrSpewllE9u9uTQbAI3v
 nvZhfid9bX7iav2j+QYG4x8laEUJRN1NDNMPHKlbliVdi9S0pzaAvuC7Y1PSILlrzwY5
 0+OyMivHwjV7Lrmu03SBDRzdGrGtiHtWgCRYI6l9+87YtX1NQ/Aa2srVB0oxySPNTbiu
 NY+0z0/Ty3fOtB9djAl+vL6WZ8EUXa5jONYoJem/tThU1JRrqqMc4H+TX7UlZoJXaUNX
 Lo/JLnLpeJQMUJqin3orYhRJtZ10+SCMfEOV+P7DXslhH01zoW4D38e0A4jl0lHTGCib 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxya1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 20:56:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NKouTl005410;
	Tue, 23 Jan 2024 20:56:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371e5n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 20:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFYLuW6E9IQxYEs8iAFNW9zpiP0eby/E4fCzjv3uwSPb6VsVuGW17F8y5noiuRiiCaNzj22UhBYuLkHJ2e7ilk2HJhfci086XZtiAY89RK5zFC+3N2jjAEk66Zi8sy2b0ZdMjMnaafN9IOxCl9qBFnqS7Bwcd63pafXcEBDUXWEvTNnfHW/lV7Zq6mTRLXMoMgvoryIpOlrMbB2lBSRm3IK0AbMJKJdRlWRkPCIEw3l46XMwJBXepfjtHunwKiatNF43iGtGin3aOa3XkW34jHw+0h8yERNApuYGtdVBELDM183DPkTbw22eigXDZYkXJhmTJn706w5z8zW4VfHstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0/Uq8Wh9z5lTXuuDqdOXKpcGNRKamEpbHRlbQq3BUY=;
 b=hkvAUXxQYwyHhbFFu/JXQKmvz3h1itLPNfxsm+4a4VZYyrIEF4GHCh8HPKmrH7B9QRh86ryHdI4e3wVh2sL7nHN9uXBNKvmPDReeKD8zZ2GAdQ4VAwQuKvY1BE5aonXxce24a5vy834TuWMggYb5ZJ6mZs4RGJxJlBAN7Kc6sSzevfamyRMmjDUvBF6iIc98ANugHXpupTOJrlJppGeIM2rZpcl1V6e7qxwYln4LV/uk5t1LNIcVxNZsoHVRR7W8N5DtFc08z9HEGseisOPxwtweM8iNXEFVh9jsersV1SnAl/TlqSxrS4dW9bLqddO7eTE3rybtgCUNUWkPiYMfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0/Uq8Wh9z5lTXuuDqdOXKpcGNRKamEpbHRlbQq3BUY=;
 b=ZvjUiwj5DgZyZCcpRe07FiHFZVNSBHPjEgax+SZptuysRwQiS9JFHNAv/eOxqFe1gq7XpC+oyXthI9gUkzXiMZ/3MEUodcvbMYFG9cD7q2UXYNfoo+nEvxv+rY1u9F8w2rsN2nWuVUJi3itJfucyXn8Ou4rKO/0bNXEttiwSzBM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BLAPR10MB4915.namprd10.prod.outlook.com (2603:10b6:208:330::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 20:56:38 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 20:56:38 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH] bpf: fix constraint in test_tcpbpf_kern.c
Date: Tue, 23 Jan 2024 21:56:24 +0100
Message-Id: <20240123205624.14746-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BLAPR10MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: 9394d79a-0e1e-4f22-9f97-08dc1c55caa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SJHte41HmLE5v29XBXwvWeeWQIZxRlYKc2of0Uaw8D5nPDkdGVB6FdgBksFgEjyHWbRaasXbWW6optnjh4yw7JFCndHAyxNDO2Z8fkO+ypT2a7TL3vKP6jz09H1wZl2vfgGe++DKKQrRBnkv5jxxgrgMkzn0NzSMvGMqhD9Jd26EDbfVQ5n+PLu+NepjVIwjQdDHibY5ito2sirgrjFGOy0fRu1Klb/f6VXVc+Y+srVJUJDNH9bYdN2sW4FXCPck6maWoIkWE4zicD96G6JX2YaYNM1g6NZpywEe9ZcvohTNg7pjA6HvB5Kb/pZo9udotzBnmMdkC2zULODAsA+1bfYVeyuJeX5vtGiaMM/i8GDD/cevwqQ2vxm6dvLA+bpfBSC+RvvePbTc1zBuLEFRHi1DKKOapheDUlvwV1kZOwqFI3kGvE1+PBcAEwFjnUA1oljJY5B+8p6dyKWmzYY8OyWo0i+6RnTjuFGZXJuD9Ig3OA8/piWYzOjQaT5QrensXrVkUsK8vmQqPc8iisZZJcnwW3ADPY/sV4ZgKKZAkdQb6OlDfUdCL1kar0njjnlamNBgHiysChUxLJBj3ksNmwacaYniFPjJW1ThT2WL1HUAxQUW9dzDhUUspj+MZcrQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(107886003)(83380400001)(6512007)(26005)(6506007)(1076003)(6666004)(2616005)(478600001)(41300700001)(4326008)(38100700002)(36756003)(6486002)(8936002)(86362001)(8676002)(66556008)(66476007)(66946007)(54906003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmJoL3gveE4wbEZUYjVvakpOTUVpZDk4SERGUDQwTkJBam0yNmFXNEFQRnRU?=
 =?utf-8?B?dzJUT3ZjMWtoVEowUEZVTHVHNC9MdTQrZy92ZTRNclRhOGl5c1J6WGRRYUgy?=
 =?utf-8?B?ZEJYejF5cTRHWk1uSWRBMEMvbUZ1dWM2b0toWFY1ZmdDeitJbzROT092RVJN?=
 =?utf-8?B?Y0ZkWURpOUh5SHpJOEtCVHNVNkFVSG12SXM4WGdrU3E3dE51alVsb05OSWdR?=
 =?utf-8?B?UWUrZkhoNTNJTUJYVnNMVUdsZFVIWUl6cC8yL01jU1VCTzUwdXB1Ri8xb053?=
 =?utf-8?B?U3hYQytPY0Z6eis2ekJQb1FzRFJHbXY1SzAyU3lraUZGdlNrU3BVd29acWtl?=
 =?utf-8?B?NW5nVWpVNlVxRGUxWG9ITmcwdFBLR1hjTDZ4NGk2YXViMUgxWEgrSU1VdVZ0?=
 =?utf-8?B?RXFyUXlJQndRSG1taWtZK1M5WU9nNTdWZW5yQ2I1c1IrajgzRDVXbzE5cXd1?=
 =?utf-8?B?MVYyYmhYNXZwQldjOWFaVHA5b0xpTi9abWZ0b3d4UWZDM3N6U0c2bkwwNEVh?=
 =?utf-8?B?K1d1N082WUVicDNEZmFnS0p1VHBhaGppeTBtODdyMzlYZ3lJN2VCS0tVUHlq?=
 =?utf-8?B?YVpRZHhlb3o4TmZwRmpnU204c2Nzb0pqMEF5RzRoY1kvQUM4UmhRWHMyc3lQ?=
 =?utf-8?B?VndBa1VzTWM4YmNlb1I4azdsMXdHY0dDSUFrMXdHZkQ4c2grNTZ1TTcwRUth?=
 =?utf-8?B?SUNrSldkYlkrRy9uaUtjVGZSYTlWSU5KWTZPbHRlUkRrb1d3T3NhRDZJdVRv?=
 =?utf-8?B?ZmRROTU3cEVJaWRtajhtNzVLejRRME04T3YxSmdkVFBqRXJMWU1QNjJac012?=
 =?utf-8?B?Y3dUYm40dkRXaVBMNy9tVk5tdnFqbFdjZnRVQ2h6TjZvTUJLc3B5SzVON0hF?=
 =?utf-8?B?WXI4RlJrTjNabXY4VzltaFhvL2hiVmpDaHQwbjRnUTFkZDVuaERUQnI4aVhX?=
 =?utf-8?B?K05QMWN2cHZBdEg2QnpCNkFYdFJkWUI4QkFyQ2tCY1RkdjQzamRBM2NORXBm?=
 =?utf-8?B?R3R1dEVpWkRjODZNeTNydjcwOWYxZHNkcWl2UytjcUdsV2poZGhTUTFjbWR3?=
 =?utf-8?B?U2x4ampCV1UvTDhRU2ZsWkdoaFZLZGZxOExFRk51WEl2NWhNaS9pQVJ4bWh0?=
 =?utf-8?B?bTRQajVVL0ZxQ0REbitkMlo4Q1VKUzFZdEljR0VZRU1hM0p0dVJzUVNLcUxT?=
 =?utf-8?B?VDRwY2pZckhLd09TR0xsZlh6TmRDa2xYNE5rRG1nM1RLb0M4Y0RVNUxzZElL?=
 =?utf-8?B?R3RlM2JxRlVTN2NteVlIZzB1TUw5eXJtU2lOL09aS1JGY2xaZmY1VEhSeit3?=
 =?utf-8?B?dVhKUUhpYklxKzd2dmpZOFM3Wnd0ZnVnWjNhRmZmZUN5Z3JISmNtYzBFTWU1?=
 =?utf-8?B?ZjRVYk1CdFFLWFRqUUxxYnZ2OE00TXdMK1lPMHNwU3pTd1JxSWlkUFFNS2JW?=
 =?utf-8?B?Wi9QaXBkSGl5amRuU0xuWmxlQWhraGh1WTJWNU9LMU5ya2RsNC9ra2txcGRJ?=
 =?utf-8?B?MkE0VVc3Q0EzR0hWTjlhdk5MTjRZY0gxRFIvK0FlTFVWYlhHUXIybjd2b2Vx?=
 =?utf-8?B?Y0d6OW1iT05Pa2xncWFKbGxGTWpyTzNkd21ZRWpaME1lYkE5ZmlIQWFkUUps?=
 =?utf-8?B?WUpWaEE3MWpnOWl2ajA3bmlmaW82b3MzcHloS2VHbEQvSHZpQ0xVTlB1S09U?=
 =?utf-8?B?Tnk0eGZXRzZtTmUxcUwrY1JoR01GcGo1ZkRvSjdqQ2dPSGhhRXpSTHc4aVFH?=
 =?utf-8?B?YXpsYUFlMTVGMHNMbE0yTWJoRVRaZEQ1dERPWFF5cWgyVU41M2tHdCs1dC9r?=
 =?utf-8?B?ZTVwc0RRazZhYVBGMGMzdGNQK05iODBxUklHaWtFZmc0aytsMElaQ21UY3J2?=
 =?utf-8?B?ZFAyYjRwQ2V3YjBHTmZTVXU3ajRqQUFUcysrNWlNSXR1WmlaRy94YlBwMW1S?=
 =?utf-8?B?NUJHOFdkM0tQUWUrZkZSV0NrWUs3Q2lTUDBIV2RwT01NU2lJQkljMU5yZkUw?=
 =?utf-8?B?djRweUdwdEJrWDV3Sk12NGk5bStPOHo0bW1uRWlOZ2FtOHo1WHVyRnZUYXlI?=
 =?utf-8?B?d21pc1ZKZHBuY3Mza2N6ajJvMlNJN0xpWFdFM0FMMk8yZDBvQUo2azlvRlFW?=
 =?utf-8?B?NUk3eXdqVENLWmFMWkUxYVRvODVGZzFYVTdJOTF6SlN0eGNZZGRHSWYybEVn?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2egMvJUmC0xs+myyjj1b9dgn2klNNEsyUyaWEeefyCQ1aO6J70DjWtnVk2cAVOta1fIm+VvI0XIbWG1iOdH3aipyTwvpzp6rrRjYNEBjE0TyPe0Ql5QauW0Y/Q4ThunkxfFQU7YHlGuxsvSnUUDHsyW0aRsBLstbQM/91hv/Y5U+bD2f3Mp2KyOHWqBFKY0LMmLKu3BZ5jk1TBvJOkP6pND4KzWG0ZNWR/RxJ34Uo8unmXk5oYj8HxOOMriKeKEhxY739Ux3j8OwRbXVkzY3oTs4YFaqN8oQOJofHQk79uCUrRDI0Wug21PsV+w0xGFGJmVTzPdTnctZLi+09Tprj+3WhnirrrVcIu6mVHTps9P1nVTcAkoeL+U3Ksd3LAKw6krlnme38LGbtiWl/HLzbRycXiR4ILj3DF2VwsxMOiHeE1cXPx6VuheGSScorkVZ/nfczODX7vkY/o6ZU0h9FGwI3FWCosbL9dMJCQER0eslEHV/bpkdK5//rsr+tnAZx7Fe0lMg4HcfJAjPFxw20O25XUVIwBhPLgFtw/GheVhCsejWVpvoq17h2uoiGOzcXHwDgIt6SDEgp3MQil6egbp+6/V7L4eF4ndBMYYHHkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394d79a-0e1e-4f22-9f97-08dc1c55caa9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 20:56:37.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ps5NDCLIQYr04rfww7ECqpjEZRedB4mUWfUZzEaSFkQI+TRDJ4aylA1WgoW+adBlasuJONuQD5fsA7oOnq6BfBdubbri4q3X7GjRrMo3t0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_13,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=757 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230154
X-Proofpoint-ORIG-GUID: C_6_HQK1MqP1vAeRHhjGa_HDhrHBcI7_
X-Proofpoint-GUID: C_6_HQK1MqP1vAeRHhjGa_HDhrHBcI7_

GCC emits a warning:

  progs/test_tcpbpf_kern.c:60:9: error: ‘op’ is used uninitialized [-Werror=uninitialized]

when an uninialized op is used iwth a "+r" constraint.  The + modifier
means a read-write operand, but that operand in the selftest is just
written to.

This patch changes the selftest to use a "=r" constraint.  This
pacifies GCC.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index cf7ed8cbb1fe..a3f3f43fc195 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -59,7 +59,7 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 
 	asm volatile (
 		"%[op] = *(u32 *)(%[skops] +96)"
-		: [op] "+r"(op)
+		: [op] "=r"(op)
 		: [skops] "r"(skops)
 		:);
 
-- 
2.30.2


